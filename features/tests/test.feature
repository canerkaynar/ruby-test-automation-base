Feature: Scenarios about Kloia Test Automation Dojo

    Background:
        Given visit homepage

    @caner @debugger
    Scenario: Search not existing item
        When fill Search with "test automation"
        Then verify "No results found" text

    @kaynar
    Scenario: Search an existing item
        When fill Search with "buttons"
        Then verify "Buttons" text at ".example-list > li:nth-of-type(1)"

    Scenario: Valid login
        And click "Sign In" link
        When fill "Email" with "dojo@kloia.com"
        And fill "Password" with "123456"
        And click "Sign In!" button
        Then verify "SIGN OUT" text

    Scenario Outline: Invalid login
        And click "Sign In" link
        When fill "Email" with "<email>"
        And fill "Password" with "<password>"
        And click "Sign In!" button
        Then verify "<expected_message>" text at ".ErrorMessage__ErrorStyles-sc-3lgc6d-0"
        Examples:
            | email             | password | expected_message                               |
            | invalid@kloia.com | 123456   | No such user found for email invalid@kloia.com |
            | dojo@kloia.com    | 654321   | Invalid Password!                              |
            | invalid@kloia.com | 654321   | No such user found for email invalid@kloia.com |

    Scenario: Register
        And click "Sign In" link
        When click "create an account" link
        Then verify "Create an account" text
        And fill "Email" with random
        And fill "Name" with "buurkeey"
        And fill "Password" with "123456"
        And click "Sign Up!" button
        Then verify "SIGN OUT" text

    Scenario Outline: Register Email Validation
        And click "Sign In" link
        When click "create an account" link
        Then verify "Create an account" text
        When fill "Email" with "<email>"
        And click "Sign Up!" button
        Then verify "<expected_message>" text
        Examples:
            | email          | expected_message                                                                                    |
            |                | Enter your email                                                                                    |
            | asdasd         | Email must be a valid email                                                                         |
            | dojo@kloia.com | This email address was previously registered in the system. Please enter a different email address. |

    Scenario: Register Name Validation
        And click "Sign In" link
        When click "create an account" link
        And fill "Name" with ""
        And click "Sign Up!" button
        Then verify "Enter your name" text

    Scenario Outline: Register Password Validation
        And click "Sign In" link
        When click "create an account" link
        And fill "Password" with "<password>"
        And click "Sign Up!" button
        Then verify "<expected_message>" text
        Examples:
            | password | expected_message                        |
            |          | Enter your password                     |
            | 1234     | Password must be at least 6 characters. |

    Scenario: Add product
        And login with "dojo@kloia.com" "123456"
        When click "Sell" link
        And upload "kloia-tshirt.jpg" file
        Then verify "kloia-tshirt" text at ".file-name"
        When fill product form with:
            | Title       | buurkeey Tsirt          |
            | Price       | 99                      |
            | Description | Silk fabric, polo tsirt |
        And click "Submit" button
        Then verify "buurkeey Tsirt" text at "h2"
        And verify "Silk fabric, polo tsirt" text at "p"
        And current url should include "/item?id="


    Scenario: Product Title Validation
        And login with "dojo@kloia.com" "123456"
        When click "Sell" link
        And fill "Title" with ""
        And click "Submit" button
        Then verify "Enter a product title" text at ".spacing-top-mini.input-feedback"

    Scenario Outline: Product Price Validation
        And login with "dojo@kloia.com" "123456"
        When click "Sell" link
        And fill "Price" with "<price>"
        And click "Submit" button
        Then verify "<expected_messsage>" text at ".spacing-top-mini.input-feedback"
        Examples:
            | price   | expected_messsage              |
            |         | Enter a product price          |
            | 1234567 | Maximum price should be 999999 |

    Scenario: Product Description Validation
        And login with "dojo@kloia.com" "123456"
        When click "Sell" link
        And fill "Description" with ""
        And click "Submit" button
        Then verify "Enter a short description" text at ".spacing-top-mini.input-feedback"

    Scenario: Find product on the page and edit product
        And login with "dojo@kloia.com" "123456"
        When click "Shop" link
        And click ".Items__ItemsList-sc-180k6a5-1 > div:nth-of-type(1) > div > div a"
        And fill product form with:
            | Title       | updated buurkeey Tsirt          |
            | Price       | 998                             |
            | Description | updated Silk fabric, polo tsirt |
        And click "Save Changes" button
        And accept alert
        Then verify "updated buurkeey Tsirt" text at "h2"
        And verify "updated Silk fabric, polo tsirt" text at "p"
        And current url should include "/item?id="

    @not_done
    Scenario: Search and edit product
        And login with "dojo@kloia.com" "123456"
        When click "Shop" link
        And fill "Search For An Item" with "buurkeey Tsirt"
        And fill product form with:
            | Title       | updated buurkeey Tsirt          |
            | Price       | 998                             |
            | Description | updated Silk fabric, polo tsirt |
        And click "Save Changes" button
        Then verify "updated buurkeey Tsirt" text at "h2"
        And verify "updated Silk fabric, polo tsirt" text at "p"
        And current url should include "/item?id="

    Scenario: Delete product
        When login with "dojo@kloia.com" "123456"
        And click "Shop" link
        And click 1. "Delete" button
        And accept alert

    Scenario: Add product to cart
        And login with "dojo@kloia.com" "123456"
        When click "Shop" link
        And add 1. product to cart
        And click "My Cart" button
        Then verify "You have 1 item in your cart." text at "header p"

    Scenario: Delete product from cart
        And login with "dojo@kloia.com" "123456"
        When click "Shop" link
        And add 1. product to cart
        And click "My Cart" button
        Then verify "You have 1 item in your cart." text at "header p"
        When delete 1. product from cart
        Then verify "You have 0 items in your cart." text at "header p"