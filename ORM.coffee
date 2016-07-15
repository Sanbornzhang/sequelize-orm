##########################
## Version --0.1
## editer : san
## date   : 07/15/16
#########################
fs        = require 'fs'
path      = require('path');
Sequelize = require 'sequelize'

#next stip change fs to loader-folder suppert yml file and json

vPath      = '../model'
module.exports = (aModel)->
  sequelize = new Sequelize('wmDBd', null, null, {
    dialect: 'sqlite',
    storage: '../wmDBd.db'
  });

  sequelize.authenticate();
  sequelize.sync({
    logging: console.log
    # force: true
  });

  vProperties = {}
  obj = require vPath + '/' + aModel.toLowerCase() + '.json'
  aProperties = obj.properties
  for item of aProperties
    vProperties[item]={}
    vType = (aProperties[item]['type']).toUpperCase()
    vIsPrimaryKey = aProperties[item]['primaryKey']?
    vIsAllowNULL  = aProperties[item]['allowNull']?
    vIsComment    = aProperties[item]['description']?
    vDefaultValue = aProperties[item]['defaultValue']?
    vAutoIncrement= aProperties[item]['autoIncrement']?

    vProperties[item].type = Sequelize[vType]

    if vIsAllowNULL   then vProperties[item]['allowNull']       = true
    if vIsPrimaryKey  then vProperties[item]['primaryKey']      = true
    if vAutoIncrement then vProperties[item]['autoIncrement']   = true
    if vIsComment     then vProperties[item]['comment']         = aProperties[item]['description']
    if vDefaultValue  then vProperties[item]['defaultValue ']   = aProperties[item]['defaultValue']

  Model = sequelize.define(aModel.toLowerCase(),vProperties)
  return Model

