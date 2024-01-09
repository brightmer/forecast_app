# Weather Checker App
**This app was created to demo RoR knowledge for applying to TEKSystems.**
The app takes an address value and provides the weather for that address as well as an extended forecast. Before checking the weather a check is made to see if we have already done a query on that postal code, if so the previous results are returned and a flash message is displayed indicating this is a cached version.

### Data
There are only two tables in the app, the first `weather_locations` is for storing the location look up and geocoding fields as well asd storing current weather. The second table `forecasts` contains the results for a point in time weather forecast. There are many forecasts for a weather location.

## Install

### Clone the repository

```shell
git clone https://github.com/brightmer/teksystems_forecast_app.git
cd teksystems_forecast_app
```

### Ruby version

```shell
ruby 3.2.2
```

### Rails version

```shell
Rails 7.1.2
```

### Install dependencies
```shell
asdf install
```
```shell
bundle install
```

### Set environment variables
This demo is using a hard coded api key for OpenWeatherAPI. This is obviously not the best practice, but this is not going to cost me any money if compromised.

### Initialize the database

```shell
rails db:create db:migrate
```

## Run development

```shell
bin/dev
```
### This will make app available on local network at <host_ip>:8080
```shell
rails s -b 0.0.0.0 -p 8080
```

## Run tests

```shell
bin/dev test
```