const { useAzureMonitor } = require("@azure/monitor-opentelemetry");
if(process.env.APPINSIGHTS_CONNECTION_STRING)
    useAzureMonitor();

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Define a simple route
app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.get('/users', (req, res) => {

    const users = [
        { name: 'John', age: 30 },
        { name: 'Jane', age: 25 },
        { name: 'Jim', age: 27 }
    ]
    res.send(users);
});


// Start the server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});