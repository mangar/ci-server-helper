# CI Server Helper


## Motivation

This project gives you some helper services when configuring a CI server for instance: controlling version of your app.

Also, it's possible to connect to Trello and export a complete board every night starting by your CI server by just GETing an URL.




## Configuration

Open the ```docker-compose.yml``` file and change the values in ```environment``` section with ones you should have from each service.




## Starting

Having Docker installed on your environment simple type: ```docker-compose up``` and then hit:   ```http://localhost:3000```

Use Postman to make the requests against your server. The base postman can be found in ```_extra``` directory



## Using

- APP_ID: this is the App ID you define for your project. For instance: __AndroidApp__
- ENVIRONMENT: this is the environment your application will be build. For instance: __Develop__, __Master__, __Store__, etc...


### 1. Creating a project / Get and increment counter by 1

__GET__ ```{{host}}/api/v1/version/APP_ID/ENVIRONMENT```

Ex.:
```{{host}}/api/v1/version/AndroidApp/develop```


Response:
```
{
    "appid": "AndroidApp",
    "environment": "develop",
    "version": {
        "date": "170627",
        "time": "211353",
        "count": 1
    }
}
```





### 2. Changing the Count

__PUT__: ```{{host}}/api/v1/version/APP_ID/ENVIRONMENT```
__Body__: parameter: version

Ex.:
```{{host}}/api/v1/version/AndroidApp/develop```


Response:
```
{
    "appId": "AndroidApp",
    "environment": "develop",
    "version": "99"
}
```





### 3. List all projects

__GET__: ```{{host}}/api/v1/get_all```


Ex.:
```{{host}}/api/v1/version/AndroidApp/develop```


Response:
```
[
    {
        "appid": "AndroidApp",
        "environment": "develop",
        "version": {
            "count": 99
        }
    }
]
```





### 4. Get and increment by one the counter

__GET__: ```{{host}}/api/v1/get_all```


Ex.:
```{{host}}/api/v1/version/AndroidApp/develop```


Response:
```
[
    {
        "appid": "AndroidApp",
        "environment": "develop",
        "version": {
            "count": 99
        }
    }
]
```







### 5. Get the last version, no increment

__GET__: ```{{host}}/api/v1/get_last/APP_ID/ENVIRONMENT```


Ex.:
```{{host}}/api/v1/get_last/AndroidApp/develop```


Response:
```
{
    "appid": "AndroidApp",
    "environment": "develop",
    "version": {
        "date": "170627",
        "time": "211924",
        "count": 100
    }
}
```










### 6. Removes a project from the list

__DEL__: ```{{host}}/api/v1/version/APP_ID/ENVIRONMENT```


Ex.:
```{{host}}/api/v1/version/AndroidApp/develop```







## Jenkins



Add this **Execute shell** on **Build** section:

```
export LC_ALL=en_US.UTF-8
./version.rb version.properties ./ AndroidApp develop develop
```

The ```version.rb``` file is in ```_extra``` directory
Open it and change the __base_url__ on the top of the file to point to your local environment or any other location where the properties file will be generated.


### Property file

By running the ```version.rb``` you have to provide some parameters:

- file_ouput: this is the name of the property file that will be generated with the version
- dir_output: directory where the property file will be generated
- appid: the App ID that will be used on calling the service
- environment: environment that will be used on calling the service


Usage:
```
./version.rb file_output dir_output appid environment
```

Ex.:
```
./version.rb version.properties ../../../app AndroidApp develop
./version.rb version.properties ../../../app AndroidApp master
```
The property file can be used to populate the version key on gradle process to build an Android app, plist in iOS file, or even use it as-is on web projects. You choose!








## BitBucket

documentation soon....





## Trello

documentation soon....






- - - 
