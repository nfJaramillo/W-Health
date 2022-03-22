var express = require('express');
var router = express.Router();
const { getAllUsers, register, getUserByUserName } = require('./controller');
const bcrypt = require ('bcrypt');

/* GET users listing. */
router.get('/', async function (req, res, next) {
  const users = await getAllUsers();
  res.json(users);
});

/* GET user. */
router.get('/:username/:psw', async function (req, res, next) {
  const users = await getUserByUserName(req.params.username);

  if(users == null)
  {
    res.json({});
  }

  else{
    bcrypt.compare(req.params.psw, users.password, function(err, result) {
      if (result) {
        res.json(users);
  
      }
      else {
        res.json({});
  
      }
  
    });
    
  }


});

/**
 * POST create user
 */
 router.post('/', async function (req, res) {
  bcrypt.hash(req.body.password, 10, (err, hash) => {
    const matchDocument = {
      username: req.body.username,
      email: req.body.email,
      password : hash,
      roles: req.body.roles
    };
    register(matchDocument, res);
  });
});

module.exports = router;
