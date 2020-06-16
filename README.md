# Setup on local with Docker
    * The project runs at port 8000, so please make sure that nothing else is running on port 8000
    * Clone the project repository
    * cd inside_project_folder/
    * docker-compose -f docker-compose-dev.yml up
    * Open another terminal and run the following commands in the same project directory.
    * docker-compose exec web bundle exec rails g duna_spree_sample:install
    
    * El comando anterior:
    *   - carga assets, views y otros archivos necesarios.
    *   - limpia las tablas de la DB.
    *   - popula la DB con los datos para Little Caesars
    *   - genera el admin user: admin@duna.hn + passwd: admin123
    * Optional: Check the DB with the command:
    *   - docker-compose run db psql -h db -U postgres spree-multi-vendor

    * Visit http://localhost:8000/


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
