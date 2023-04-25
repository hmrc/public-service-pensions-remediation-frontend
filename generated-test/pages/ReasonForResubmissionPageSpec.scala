package pages

import pages.behaviours.PageBehaviours


class ReasonForResubmissionPageSpec extends PageBehaviours {

  "ReasonForResubmissionPage" - {

    beRetrievable[String](ReasonForResubmissionPage)

    beSettable[String](ReasonForResubmissionPage)

    beRemovable[String](ReasonForResubmissionPage)
  }
}
