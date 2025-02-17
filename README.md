# TISS Information System

This is a Ruby on Rails project for retrieving and displaying information about courses, lecturers, and other related data from the TISS system of TU Vienna.

## Ruby and Rails Versions

- Ruby Version: 3.1.2
- Rails Version: 7.0.1

## Project Description

The TISS Information System allows users to search for and view details about courses and lecturers at TU Vienna. Users can also add favorites and generate printable lists for each category.

## Features

- User registration and login
- Search functionality for courses and lecturers
- Detailed view for each course and lecturer
- Add to favorites functionality
- Printable lists for each category
- Responsive design with custom CSS

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/tiss_information_system.git
    cd tiss_information_system
    ```

2. Install the required gems:
    ```sh
    bundle install
    ```

3. Set up the database:
    ```sh
    rails db:create
    rails db:migrate
    ```

4. Start the Rails server:
    ```sh
    rails server
    ```

5. Open your browser and navigate to `http://localhost:3000`.

## Usage

- Register a new user or log in with an existing account.
- Use the search functionality to find courses and lecturers.
- View detailed information about each course and lecturer.
- Add courses and lecturers to your favorites.
- Generate and print lists of your favorite courses and lecturers.

## Timetable

### Jahn David

| Date       | Time spent | Description                                                       |
|------------|------------|-------------------------------------------------------------------|
| 24.04.2023 | 05:00 h    | Finished person search, added person details, changed font-family |
| 26.04.2023 | 04:30 h    | Added details functionality; added links for person details       |
| 28.04.2023 | 02:00 h    | Finished details functionality; added CSS                         |
| 23.05.2023 | 04:00 h    | Added favorites functionality                                     |
| 18.06.2023 | 02:00 h    | Meeting, going over all the requirements/fixing bugs              |
| 19.06.2023 | 01:00 h    | Testing, fixing bugs                                              |

### Märzinger Manuel

| Date       | Time spent | Description                                                                                                          |
|------------|------------|----------------------------------------------------------------------------------------------------------------------|
| 03.04.2022 | 04:30 h    | Setup development environment and repository, implementation of register and login                                   |
| 19.04.2022 | 01:50 h    | Password confirm for registration, start of person search controller                                                 |
| 24.04.2022 | 02:00 h    | Small refactoring changes, full implementation of search controllers                                                 |
| 30.04.2022 | 05:20 h    | Can now add favorites, can now add augments                                                                          |
| 11.06.2022 | 03:30 h    | Added printable list for each category                                                                               |
| 12.06.2022 | 07:00 h    | Refactoring of all controllers; started implementing requirement 10, implemented full person report + search functionality |
| 18.06.2023 | 02:00 h    | Meeting, going over all the requirements/fixing bugs                                                                 |
| 19.06.2023 | 01:45 h    | Bug fixes, styling, etc...                                                                                           |



## License

This project is licensed under the MIT License. See the LICENSE file for details.