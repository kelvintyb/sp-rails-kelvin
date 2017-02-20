## Installation

 1. Git clone this repo into a local repo

 2. Run `bundle` to install gems used for the installation
 3. Run `rails db:create`, `rails db:migrate`, `rails db:seed` to set up database; Database would be seeded with the users outlined in the assignment brief without any relationships established

 4. Run `rspec` to run tests of the feature specs

### Gems used

Below are the main gems I utilised for this implementation:

Gem | Purpose
---------- | -------
Rspec-rails| Testing
Factory_girl_rails | Replacement of fixtures
Faker | Random generation of attributes for factory girl
Database_cleaner | For refreshing of test database while running test suite

## Endpoints
Note: Please follow the format for the data parameter of the curl request e.g. `-d '{"email": "common@example.com"}'`; it does not work if double quotation marks are used to wrap the data parameter input

#### Create a User

Example Request:
```
curl -H "Content-Type: application/json" -d '{"email": "kelvin@example.com"}' -X POST "http://localhost:3000/users"
```

#### User Story 1

Example Request:
```
curl -H "Content-Type: application/json" -d '{"friends": ["andy@example.com","john@example.com"]}' -X POST "http://localhost:3000/friendships"
```
#### User Story 2

Example Request:
```
curl -H "Content-Type: application/json" -d '{"email": "andy@example.com"}' -X GET "http://localhost:3000/friendships"
```
#### User Story 3

Example Request:
```
curl -H "Content-Type: application/json" -d '{"friends": ["andy@example.com","john@example.com"]}' -X GET "http://localhost:3000/friendships/common"
```
#### User Story 4

Example Request:
```
curl -H "Content-Type: application/json" -d '{"requestor": "lisa@example.com","target": "john@example.com"}' -X POST "http://localhost:3000/subscriptions"
```
#### User Story 5

Example Request:
```
curl -H "Content-Type: application/json" -d '{"requestor": "andy@example.com","target": "john@example.com"}' -X POST "http://localhost:3000/blockades"
```
#### User Story 6

Example Request:
```
curl -H "Content-Type: application/json" -d '{"sender": "john@example.com","text": "Hello World! kate@example.com"}' -X GET "http://localhost:3000/subscriptions"
```

## Implementation Notes

#### File Structure
1. Models and Controllers are in `app/models` and `app/controllers` respectively; normally I would version it (eg. `app/api/v1/controllers`) but kept it simple for easier navigation
2. Database migrations and seed file are in the `db` folder
3. Test specs are in the `spec` folder and are executed on `rspec` in the console

### Database Modelling

I chose to design 4 data models to reflect the data given: User, Friendship, Blockade and Subscription (pls refer to `db/schema.rb` for full attributes & validations). 

The relationships were implemented as separate models in order to maintain modularity & keep the code base easily extensible (e.g. if more attributes need to be tracked at the Subscription model). In particular, while both Blockade and Subscription are asymmetrical relationships - I elected to separate them so that Blockade relationships/table can be removed without dirtying the Subscription data (and vice versa).
