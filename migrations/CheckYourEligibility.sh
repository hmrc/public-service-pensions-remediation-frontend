#!/bin/bash

echo ""
echo "Applying migration CheckYourEligibility"

echo "Adding routes to conf/app.routes"
echo "" >> ../conf/app.routes
echo "GET        /checkYourEligibility                       controllers.CheckYourEligibilityController.onPageLoad()" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "checkYourEligibility.title = checkYourEligibility" >> ../conf/messages.en
echo "checkYourEligibility.heading = checkYourEligibility" >> ../conf/messages.en

echo "Migration CheckYourEligibility completed"
