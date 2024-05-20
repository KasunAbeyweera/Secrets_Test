import ballerina/http;
import ballerina/os;
import ballerina/log;


@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"],
        allowCredentials: true,
        allowHeaders: ["accept", "Content-Type"],
        exposeHeaders: ["X-CUSTOM-HEADER"],
        maxAge: 84900
    }
}

isolated service / on new http:Listener(9091) {

    resource function get getKey(string name) returns string|error {
    string TestKey = os:getEnv("TEST_KEY");
    log:printInfo("Pinecone Service URL: ");

    if name is () {
        return error("Name should not be empty!");
    } else if TestKey is () {
        return error("TestKey is not defined in the environment variables.");
    }

    int|error convertedKey = int:fromString(TestKey);
    if convertedKey is error {
        return error("Failed to convert TestKey to an integer.");
    }

    int result = convertedKey * 2;
    return string `Hello, ${name}, Your key is ${result}!`;
}

}

