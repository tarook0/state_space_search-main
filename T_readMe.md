# How to Use

Step 1:

Download or clone this repo by using the link below:

<https://gitlab.com/tarook0/state_space_search.git>
Step 2:

Go to project root and execute the following command in console to get the required dependencies:

$ dart pub get
Step 3:

Go to state_space_serach.dart and run it be sur you have launch.json with this configurations
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: <https://go.microsoft.com/fwlink/?linkid=830387>
    "version": "0.2.0",
    "configurations": [
        {
            "name": "state_space_search",
            "request": "launch",
            "type": "dart"
        }
    ]
}

# Here is the core folder structure which flutter provides
state_space_search/
|- dart_tool
|- .vscode
|- bin
|- lib
|- test

bin/
|-state_space_search.dart

lib/
|-Dijkstra/
|-graph/
|-heap/
|-priority_queue/
|-queue/
