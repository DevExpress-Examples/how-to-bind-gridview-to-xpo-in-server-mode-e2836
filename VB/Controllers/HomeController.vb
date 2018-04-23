Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Mvc

Namespace Q301588.Controllers
	<HandleError> _
	Public Class HomeController
		Inherits Controller
		Public Function Index() As ActionResult
			ViewData("Message") = "How to bind GridView to XPO in Server Mode"

			Return View()
		End Function

		Public Function GridViewPartial() As ActionResult
			Return PartialView("GridViewPartial")
		End Function
	End Class
End Namespace
