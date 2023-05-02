package pages

import pages.behaviours.PageBehaviours

class IsRSSReceivedPageSpec extends PageBehaviours {

  "IsRSSReceivedPage" - {

    beRetrievable[Boolean](IsRSSReceivedPage)

    beSettable[Boolean](IsRSSReceivedPage)

    beRemovable[Boolean](IsRSSReceivedPage)
  }
}
