!/bin/bash

# Get the current date
current_date=$(date +%s)
# Get a list of all IAM users
iam_users=$(aws iam list-users --query 'Users[*].UserName' --output text)

# Loop through each user and check if they have any access keys older than 90 days
for user in $iam_users; do
  access_keys=$(aws iam list-access-keys --user-name $user --query 'AccessKeyMetadata[*].[AccessKeyId,CreateDate]' --output text)

  # Loop through each access key and check its age
  for access_key in $access_keys; do
    key_id=$(echo $access_key | awk '{print $1}')
    create_date=$(echo $access_key | awk '{print $2}' | cut -d'T' -f1)
    create_timestamp=$(date -d $create_date +%s)
    age_in_days=$(( (current_date - create_timestamp) / (60*60*24) ))

    # If the access key is older than 90 days, delete the user and associated resources
    if [[ $age_in_days -gt 90 ]]; then
      echo "Deleting IAM user $user with access key $key_id older than 90 days"

      # Delete the user's policies
      user_policies=$(aws iam list-user-policies --user-name $user --query 'PolicyNames[*]' --output text)
      for policy in $user_policies ; do
        aws iam delete-user-policy --user-name $user --policy-name $policy
      done

      # Detach the user's attached policies
      user_attached_policies=$(aws iam list-attached-user-policies --user-name $user --query 'AttachedPolicies[*].PolicyArn' --output text)
      for policy_arn in $user_attached_policies ; do
        aws iam detach-user-policy --user-name $user --policy-arn $policy_arn
      done

      # Remove the user from any groups they are a member of
      user_groups=$(aws iam list-groups-for-user --user-name $user --query 'Groups[*].GroupName' --output text)
      for group in $user_groups ; do
        aws iam remove-user-from-group --user-name $user --group-name $group
      done

      # Delete the user's access keys
      user_access_keys=$(aws iam list-access-keys --user-name $user --query 'AccessKeyMetadata[*].AccessKeyId' --output text)
      for key in $user_access_keys ; do
        aws iam delete-access-key --user-name $user --access-key-id $key
      done

      # Delete the user's login profile
      aws iam delete-login-profile --user-name $user

      # Delete the user
      aws iam delete-user --user-name $user

      # Break out of the inner loop since we don't need to check any more access keys for this user
      break
    fi
  done
done