## S3 Static Website Deployment Steps

1. Deploying an S3 Bucket
   Provision the base AWS S3 bucket resource using Terraform.

2. Disabling Public Access Block
   Configure `aws_s3_bucket_public_access_block` settings to allow public read access for website hosting.

3. Configuring the S3 Static Website
   Enable the website configuration block on the S3 bucket and define the `index.html` and `error.html` documents.

4. Uploading Files to S3 via Terraform
   Use `aws_s3_object` resources to automatically upload website assets (HTML, CSS, JS) to the S3 bucket during deployment.
