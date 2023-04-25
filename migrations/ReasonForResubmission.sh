#!/bin/bash

echo ""
echo "Applying migration ReasonForResubmission"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /reasonForResubmission                        controllers.ReasonForResubmissionController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /reasonForResubmission                        controllers.ReasonForResubmissionController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeReasonForResubmission                  controllers.ReasonForResubmissionController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeReasonForResubmission                  controllers.ReasonForResubmissionController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "reasonForResubmission.title = reasonForResubmission" >> ../conf/messages.en
echo "reasonForResubmission.heading = reasonForResubmission" >> ../conf/messages.en
echo "reasonForResubmission.checkYourAnswersLabel = reasonForResubmission" >> ../conf/messages.en
echo "reasonForResubmission.error.required = Enter reasonForResubmission" >> ../conf/messages.en
echo "reasonForResubmission.error.length = ReasonForResubmission must be 100 characters or less" >> ../conf/messages.en
echo "reasonForResubmission.change.hidden = ReasonForResubmission" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryReasonForResubmissionUserAnswersEntry: Arbitrary[(ReasonForResubmissionPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ReasonForResubmissionPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test-utils/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test-utils/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryReasonForResubmissionPage: Arbitrary[ReasonForResubmissionPage.type] =";\
    print "    Arbitrary(ReasonForResubmissionPage)";\
    next }1' ../test-utils/generators/PageGenerators.scala > tmp && mv tmp ../test-utils/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ReasonForResubmissionPage.type, JsValue)] ::";\
    next }1' ../test-utils/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test-utils/generators/UserAnswersGenerator.scala

echo "Migration ReasonForResubmission completed"
