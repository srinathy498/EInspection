<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShipMapping.aspx.cs" MasterPageFile="~/Site.Master" Inherits="E_Inspection.Forms.ShipMapping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%= Page.ResolveClientUrl("~/scripts/jquery-3.3.1.min.js") %>"></script>
    <script type="text/javascript">

        function GetShipDetails() {
            $.ajax({
                type: "POST",
                url:'<%=ResolveUrl("ShipMaster.aspx/GetShipDetails") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessCustomer,
                failure: function (response) {
                    //alert(response.responseText);
                },
                error: function (response) {
                    //alert(response.responseText);
                }

            });
        }
        function OnSuccessCustomer(response) {
            var jsondata = $.parseJSON(response.d);
            var dt = $('#Shiptable').DataTable({
                data: jsondata.ShipMaster,
                destroy: true,
                "columns": [
                    {
                        "class": "edit_btn",
                        "mRender": function (data, type, row) {
                            return '<a  href="javascript: void (0);" data-dismiss="modal" aria-label="Close">' + row.ShipId + '</a > ';

                        }
                    },
                    { "data": "Name" },
                    { "data": "Type" },
                    { "data": "ContactNumber" }
                ]
            });
            $('#Shiptable').on('click', 'tbody .edit_btn', function () {
                var data_row = dt.row($(this).closest('tr')).data();
                if (data_row) {
                    $('#MainContent_txtShipID').val(data_row.ShipId);
                    $('#MainContent_txtName').val(data_row.Name);
                    $('#MainContent_txtType').val(data_row.Type);
                    $('#MainContent_txtContact').val(data_row.ContactNumber);
                    document.getElementById("MainContent_ddlManager").value = data_row.SMangerId;

                    $('#MainContent_txtAddress').val(data_row.Address);
                    $('#MainContent_txtCity').val(data_row.City);
                    $('#MainContent_txtDiscription').val(data_row.Discription);
                    $('#MainContent_btnSubmit')[0].innerText = "Update";
                    $('#MainContent_btnSubmit')[0].value = "Update";
                    $('#MainContent_btnhdn')[0].value = "Update";

                }
            });
        }
        function successalert(msginfo) {
            swal({
                text: msginfo,
                type: 'success'
            }).then(function () {
                location.href = "ShipMapping.aspx";
            });
        }
         function tableToJson(table) {
            var data = [], i, j = 0; // first row needs to be headers var headers = []; 
            var table = $("#MainContent_tblMapping tbody tr");
            var cellshead = new Array();
            var cells = new Array();
            $('#MainContent_tblMapping tr th').each(function () {
                cellshead.push($(this));
            });
            if ($('#MainContent_tblMapping tr').length > 1) {
                $('#MainContent_tblMapping tr').each(function () {
                    if ($(this).find('td').length != 0)
                        data.push($(this).find('td')[0].innerHTML + ':' + $(this).find('td')[1].innerHTML+":" + $(this).find('td select').val())
                });
                document.getElementById('<%=HiddenField1.ClientID%>').value = data;
            }
            else {
                document.getElementById('<%=HiddenField1.ClientID%>').value = "";
            }
        }
    </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
   <div>
       <input type="hidden" id="HiddenField1" runat="server" />
        <div class="content-wrapper">
          <div class="row">            
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                  <h4 class="card-title">SHIP Mapping</h4>
                <div class="card-body">
                   <br />                 
                    <label class="col-form-label text-danger" id="lblerror" runat="server"></label>                    
                    <div class="row" style="display:none;">
                    <div class="col-md-12 stretch-card">
                    <div class="card">
                        <div class="card-body">                           
                            <div class="table-responsive">
                                <table id="tblMapping" class="table table-bordered dataTable no-footer" runat="server">
                                    <thead>
                                        <tr>
                                            <th style="display:none; background-color: #6198B7;padding: 0.50rem 0.9375rem;">UserID</th>
                                            <th style="background-color: #6198B7;padding: 0.50rem 0.9375rem;">User Name</th>
                                            <th style="background-color: #6198B7;padding: 0.50rem 0.9375rem;">Ship</th>                                                                                      
                                        </tr>
                                    </thead>
                                    <tbody>                                                                                                                   
                                    </tbody>
                                </table>
                            </div>
                            </div>
                        </div>
                    </div>
                    </div> 
                    
                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Tanker Name</label>
                          <div class="col-sm-9">
                            <select class="form-control" id="ddlUser" runat="server" required="required">                                                            
                            </select>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Ship Name</label>
                          <div class="col-sm-9">
                         <select class="form-control" id="ddlShip" runat="server" required="required">                                                                                  
                        </select>
                          </div>
                        </div>
                      </div>
                    </div>
                     <div class="row">
                         <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Vetter Name</label>
                          <div class="col-sm-9">
                            <select class="form-control" id="ddlVetter" runat="server" required="required">                                                            
                            </select>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Job Id</label>
                          <div class="col-sm-9">
                           <input type="text" class="form-control" id="txtJobId" placeholder="Job Id" runat="server" required="required">
                          </div>
                        </div>
                      </div>                      
                    </div> 
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Company</label>
                          <div class="col-sm-9">
                            <select class="form-control" id="ddlCompany" runat="server" required="required">                                                            
                            </select>
                          </div>
                        </div>
                      </div>
                        </div>   
                    <div class="row">
                         <div class="col-md-8 offset-md-4">   
                    <asp:Button Text="Submit" class="btn btn-primary mr-2" runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" />
                    <a class="btn btn-danger" href="ShipMapping.aspx">Cancel</a>
                             </div>
                        </div>                 
                </div>
              </div>
            </div>           
          </div>            
          </div>
      </div>
    <div class="modal fade" id="ShipModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 130%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ship Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="Shiptable" width="100%">
                                <thead>
                                    <tr>
                                        <th>Ship ID</th>
                                        <th>Name</th>
                                        <th>Type</th>
                                        <th>Contact</th>                                       
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-danger" type="button" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    <input type="hidden" id="btnhdn" runat="server" />
   </asp:Content>
