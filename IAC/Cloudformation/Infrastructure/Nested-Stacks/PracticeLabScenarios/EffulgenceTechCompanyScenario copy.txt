Atlas Manufacturing Group, a mid-sized manufacturing firm, has been operating on-premises for over a decade. Their IT infrastructure includes legacy systems, physical servers, and manual processes for system management. The company has been facing multiple challenges due to the limitations of their on-premises setup, which has started affecting their business operations and growth. Some of the challenges faced are:

1. Scalability Issues
   Existing hardware cannot handle growing workloads.
   Adding new servers requires significant upfront investment and time.
2. High Operational Costs
   Costs for maintaining data centers, including power, cooling, and hardware, are skyrocketing.
   Frequent hardware failures require costly replacements.
3. Disaster Recovery Limitations
   No effective disaster recovery plan is in place.
   Data loss during hardware failures has impacted business continuity.
4. Lack of Agility
   Delays in deploying new applications or updates due to manual processes.
   Difficulty in adapting to market demands due to inflexible systems.
5. Security Concerns
   Inadequate resources for implementing strong cybersecurity measures.
   Frequent system vulnerabilities due to outdated software.
6. Limited Collaboration
   Difficulty in enabling remote work due to the lack of centralized access.
   File sharing and collaboration across teams are inefficient.
7. Compliance Challenges
   Struggles to meet evolving industry standards and regulations.
   Manual processes make compliance audits tedious and error-prone.

The CEO, John Milton, recently learned about cloud computing and recognized its potential to address many of the company’s current challenges. He reached out to Effulgence Tech for assistance with the transition. Following a thorough assessment of cloud capabilities, the decision was made to move forward with the migration. You have been designated as the lead engineer for the project, with the additional responsibility of providing input based on your extensive experience with similar migrations.

**Applications to be migrated:**
TaskFlow, ShopEase, QuickBuy, TrendTalk, Wellness360, BudgetWise, ActiveYou, WatchPoint

On the first day of the project, your manager, Timi, approaches you with the following tasks to complete before initiating the migration:

1. **Granting Access:** Two AWS accounts (stage and prod) have been created for the client. Timi needs you to grant Michael, the new engineer, read-only access to these accounts via IAM Identity Center, as he will be assisting with the project.
2. **CLI Setup Assistance:** Michael is unfamiliar with setting up CLI profiles. Provide clear instructions on how to configure profiles for both accounts.
3. **On-Premises Inventory:** The company has limited information about its on-premises infrastructure, which could delay the migration. Recommend a tool to gather the necessary server data and explain how it will streamline the migration process.
4. **Lift and Shift Tools:** The company has decided to retain some applications, retire others, and perform a lift-and-shift for the majority. Recommend an AWS tool to facilitate the lift-and-shift process and guide the team in implementing it.
5. **Migration Strategy:** The project manager suggests migrating all servers simultaneously to expedite the process. Is this advisable? Provide reasoning for your recommendation.
6. **Server Access Post-Migration:** After migrating the first wave of servers, application owners need quick access, but Active Directory has not been set up yet. Propose a secure and efficient method to grant access.
7. **Secure S3 Bucket Setup:** ShopEase application owners request a new S3 bucket restricted to their servers for storing PHI. Explain how you would securely configure this bucket.
8. **Demonstration of S3 Configuration:** After setting up the S3 bucket, demonstrate its functionality to the team.
9. **Local Access to S3:** The team needs local access to the S3 bucket to transfer files. Provide a solution and demonstrate its implementation.
10. **Scalability Issues:** To address scalability challenges previously encountered on-premises, recommend an AWS service that ensures optimal performance during peak hours.
11. **Implementation and High Availability:** Set up the recommended scalability solution, considering high availability, and explain its setup and benefits to Michael, who will shadow you.
12. **Server Identification:** Some team members require easy access to servers without remembering IP addresses. Propose a solution for this challenge.
13. **Load Balancer Configuration:** The TaskFlow team requests a load balancer record pointing to two servers. Suggest a suitable solution.
14. **Cost-Effective Disaster Recovery:** The company seeks a cost-efficient disaster recovery solution with acceptable RTO/RPO in hours. Recommend an appropriate approach.
15. **Scaling for New Applications:** With plans to onboard additional applications, recommend a solution for provisioning new servers.
16. **Compliance and Security Tools:** Ensure all servers have the required security tools installed and validate that the process is successful.
17. **Monthly Patching:** Implement a solution to ensure all servers are patched monthly.
18. **Cost Optimization for EC2:** Significant expenses have been noted from EC2 instances running 24/7, despite no deployments after 7 PM. Recommend a cost-saving tool.
19. **Tool Implementation:** Set up the cost-saving tool for both stage and prod environments. Explain its functionality to Michael, who will shadow you.
20. **Further Cost Reductions:** After achieving significant savings, explore and recommend additional strategies to reduce costs further.
