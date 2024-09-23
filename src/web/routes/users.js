var express = require('express');
var router = express.Router();
var axios = require('axios');

/* GET users listing. */
router.get('/', async function(req, res, next) {

  const url = process.env.API_URL || 'http://localhost:3000';

  try {
    console.log('Calling users service at:', url);
    const response = await axios.get(`${url}/users`);
    // get users from another service
    res.send(response.data);
  } catch (error) {
    res.status(500).send(error.message);
  }
});

module.exports = router;
