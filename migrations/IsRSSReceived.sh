#!/bin/bash

echo ""
echo "Applying migration IsRSSReceived"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /isRSSReceived                        controllers.IsRSSReceivedController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /isRSSReceived                        controllers.IsRSSReceivedController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeIsRSSReceived                  controllers.IsRSSReceivedController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeIsRSSReceived                  controllers.IsRSSReceivedController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "isRSSReceived.title = isRSSReceived" >> ../conf/messages.en
echo "isRSSReceived.heading = isRSSReceived" >> ../conf/messages.en
echo "isRSSReceived.checkYourAnswersLabel = isRSSReceived" >> ../conf/messages.en
echo "isRSSReceived.error.required = Select yes if isRSSReceived" >> ../conf/messages.en
echo "isRSSReceived.change.hidden = IsRSSReceived" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsRSSReceivedUserAnswersEntry: Arbitrary[(IsRSSReceivedPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[IsRSSReceivedPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test-utils/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test-utils/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsRSSReceivedPage: Arbitrary[IsRSSReceivedPage.type] =";\
    print "    Arbitrary(IsRSSReceivedPage)";\
    next }1' ../test-utils/generators/PageGenerators.scala > tmp && mv tmp ../test-utils/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(IsRSSReceivedPage.type, JsValue)] ::";\
    next }1' ../test-utils/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test-utils/generators/UserAnswersGenerator.scala

echo "Migration IsRSSReceived completed"
