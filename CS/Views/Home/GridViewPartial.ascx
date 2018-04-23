<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% 
    Html.DevExpress().GridView(
        settings => {
            settings.Name = "gvDataBindingToLinq";
            settings.CallbackRouteValues = new { Controller = "Home", Action = "GridViewPartial" };
            settings.KeyFieldName = "Oid";
            settings.Width = Unit.Percentage(100);
            settings.Settings.ShowFilterRow = true;
            settings.Settings.ShowGroupPanel = true;
            settings.Settings.ShowFooter = true;

            MVCxGridViewColumn column = settings.Columns.Add("Oid", MVCxGridViewColumnType.TextBox);
            column.SortIndex = 0;
            column.SortOrder = DevExpress.Data.ColumnSortOrder.Ascending;
            
            settings.Columns.Add("Title", MVCxGridViewColumnType.TextBox).Width = Unit.Percentage(70);
        })
        .BindToLINQ("", "", new EventHandler<DevExpress.Data.Linq.LinqServerModeDataSourceSelectEventArgs>((s, e) => {
            e.KeyExpression = "Oid";

            DevExpress.Xpo.Session session = XpoHelper.GetNewSession();
            DevExpress.Xpo.XPQuery<MyObject> query = new DevExpress.Xpo.XPQuery<MyObject>(session);

            e.QueryableSource = query;
        }))
        .Render();
%>
