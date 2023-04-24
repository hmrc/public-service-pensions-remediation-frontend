package pages

import pages.behaviours.PageBehaviours

class ResubmittingAdjustmentPageSpec extends PageBehaviours {

  "ResubmittingAdjustmentPage" - {

    beRetrievable[Boolean](ResubmittingAdjustmentPage)

    beSettable[Boolean](ResubmittingAdjustmentPage)

    beRemovable[Boolean](ResubmittingAdjustmentPage)
  }
}
