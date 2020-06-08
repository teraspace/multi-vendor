# Setup on local with Docker
    * The project runs at port 8000, so please make sure that nothing else is running on port 8000
    * Clone the project repository
    * cd inside_project_folder/
    * docker-compose up --build
    * Open another terminal and run the following commands in the same project directory.
    * docker-compose exec web bundle exec rails g duna_spree_sample:install
    * docker-compose exec web bundle exec rake duna_spree_sample:clear_tables
    * docker-compose exec web bundle exec rails db:migrate
    * Optional: Chech tables are created and cleaned with the command:
        * docker-compose run db psql -h db -U postgres spree-multi-vendor
    * docker-compose exec web bundle exec rake duna_spree_sample:load
    * docker-compose exec web bundle exec rake spree_auth:admin:create

    * Visit http://localhost:8000/

    * Tuve que hacer:
    * Ctrl-C
    * $ docker-compose down
    * $ docker-compose build
    * $ docker-compose up
    * docker-compose up --build



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
