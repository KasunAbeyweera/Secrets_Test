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

    resource function get getKey(string? name) returns string|error {
        string TestKey = os:getEnv("TEST_KEY");
        log:printInfo("Pinecone Service URL: " + TestKey);

        if name is () {
            return error("name should not be empty!");
        }
        return string `Hello, ${name}, Your key is ${TestKey}!`;
    }
}

