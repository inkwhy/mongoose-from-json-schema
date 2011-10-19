vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'
specHelper = require './spec_helper'

vows.describe("integration_task")
  .addBatch
    "CLEANUP TEMP":
      topic: () ->
        specHelper.cleanTmpFiles []
      "THEN IT SHOULD BE CLEAN :)": () ->
        assert.isTrue true        
  .addBatch
    "SETUP" :
      topic: () -> 
        specHelper.setup @callback
        return
      "THEN IT SHOULD BE SET UP :)": () ->
        assert.isTrue true
  .addBatch
    "WHEN adding a json schema" :
      topic: () -> 
        @xx =  new main.JsonSchemaToMongoose()
        @xx.addJsonSchema "hello", {},@callback
        return
      "THEN it should have been added": (err,newEntity) ->
        assert.isNotNull @xx.schemas['hello']
      "THEN it's jsonName should be set" : (err,newEntity) ->
        assert.equal @xx.schemas['hello'].jsonName ,"hello"
      "THEN it's properties count should be 0"  : (err,newEntity) ->
          assert.equal newEntity.properties.length ,0
      "THEN it's originalSchema object should be set"  : (err,newEntity) ->
          assert.isNotNull @xx.schemas['hello'].originalSchema
      
  .export module
