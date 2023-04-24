#!/bin/bash

echo ""
echo "Applying migration ResubmittingAdjustment"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /resubmittingAdjustment                        controllers.ResubmittingAdjustmentController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /resubmittingAdjustment                        controllers.ResubmittingAdjustmentController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeResubmittingAdjustment                  controllers.ResubmittingAdjustmentController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeResubmittingAdjustment                  controllers.ResubmittingAdjustmentController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "resubmittingAdjustment.title = resubmittingAdjustment" >> ../conf/messages.en
echo "resubmittingAdjustment.heading = resubmittingAdjustment" >> ../conf/messages.en
echo "resubmittingAdjustment.checkYourAnswersLabel = resubmittingAdjustment" >> ../conf/messages.en
echo "resubmittingAdjustment.error.required = Select yes if resubmittingAdjustment" >> ../conf/messages.en
echo "resubmittingAdjustment.change.hidden = ResubmittingAdjustment" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryResubmittingAdjustmentUserAnswersEntry: Arbitrary[(ResubmittingAdjustmentPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ResubmittingAdjustmentPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test-utils/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test-utils/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryResubmittingAdjustmentPage: Arbitrary[ResubmittingAdjustmentPage.type] =";\
    print "    Arbitrary(ResubmittingAdjustmentPage)";\
    next }1' ../test-utils/generators/PageGenerators.scala > tmp && mv tmp ../test-utils/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ResubmittingAdjustmentPage.type, JsValue)] ::";\
    next }1' ../test-utils/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test-utils/generators/UserAnswersGenerator.scala

echo "Migration ResubmittingAdjustment completed"
