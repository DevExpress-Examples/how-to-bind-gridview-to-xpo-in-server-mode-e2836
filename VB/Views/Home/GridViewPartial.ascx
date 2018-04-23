<%@ Control Language="vb" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    Html.DevExpress().GridView(Function(settings)
                                   settings.Name = "gvDataBindingToLinq"
                                   settings.CallbackRouteValues = New With { _
                                    Key .Controller = "Home", _
                                    Key .Action = "GridViewPartial" _
                                   }
                                   settings.KeyFieldName = "Oid"
                                   settings.Width = Unit.Percentage(100)
                                   settings.Settings.ShowFilterRow = True
                                   settings.Settings.ShowGroupPanel = True
                                   settings.Settings.ShowFooter = True
                                   Dim column As MVCxGridViewColumn = settings.Columns.Add("Oid", MVCxGridViewColumnType.TextBox)
                                   column.SortIndex = 0
                                   column.SortOrder = DevExpress.Data.ColumnSortOrder.Ascending
                                   settings.Columns.Add("Title", MVCxGridViewColumnType.TextBox).Width = Unit.Percentage(70)

                               End Function).BindToLINQ("", "", New EventHandler(Of DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs)(Function(s, e)
                                                                                                                                                      e.KeyExpression = "Oid"
                                                                                                                                                      Dim session As DevExpress.Xpo.Session = XpoHelper.GetNewSession()
                                                                                                                                                      Dim query As New DevExpress.Xpo.XPQuery(Of MyObject)(session)
                                                                                                                                                      e.QueryableSource = query

                                                                                                                                                  End Function)).Render()
%>
