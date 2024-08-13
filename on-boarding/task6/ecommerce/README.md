# Flutter E-Commerce App

This e-commerce flutter app is architcted using principles of clean architecture and incorporates test-driven-development practices. By adopting well-defined separation of concerns, it is scalable, maintainable and testable.


## Architecture

This app uses Test-Driven-Development(TDD) priciples and is going to be made as cleanly as possible.
Code is separated into independent layers and depend on abstractions instead of concrete implementations.

The app is divided into three key layers: Domain, Data, and Presentation

### Domain Layer
This is the inner layer, where everything begins. Domain is the inner layer which shouldn't be susceptible to  changing data sources or such. It will contain only the core business logic (use cases), business objects (entities), and repositories (unimplemented). It should be totally independent of every other layer.

### Data Layer
The data layer consists of models, Repository implementation (based on the contract that comes from the domain) and data sources (local and remote) - one is usually for getting remote (API) data and the other for caching that data. 

### Presentation Layer
The Presentation Layer is a crucial part of the application architecture. It is responsible for managing the user interface (UI) and handling the interaction between the user and the application.

## Usage
The app will be used in viewing products, getting the details of specific products, creating a product, updating a product and deleting a product. 


## Installation

To set up and run the project, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/luhygenet/2024-project-phase-mobile-tasks.git