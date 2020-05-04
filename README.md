# Setup on local with Docker
    * Clone the project repository
    * cd inside_project_folder/
    * docker-compose up --build -d
    * docker-compose exec web bundle exec rails db:create
    * docker-compose exec web bundle exec rails db:migrate
    * docker-compose exec web bundle exec rails db:seed
    * docker-compose exec web bundle exec rake spree_sample:load 
    * docker-compose exec web bundle exec rails g spree:frontend:copy_storefront
    * docker-compose exec web bundle exec rake spree_multi_vendor:sample:create
    

# Deploy on development server
* **Prerequisites**:
    * Install [awscli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html).
    * Configure **aws**
        * Run **aws configure**
            ```
          AWS Access Key ID: 
          AWS Secret Access Key: 
          Default region name: 
          Default output format:
* **Run the commands inside the project folder**
    * **eb init**
        * For initialization
    * **eb list**
        * To verify your environment.
    * **eb deploy**
        * It will deploy the changes till last commit changes on development server.
        
#### Note:
    Don't forget to commit your changes before deployment.
