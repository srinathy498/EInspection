<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShipManager.aspx.cs" MasterPageFile="~/Site.Master" Inherits="E_Inspection.Forms.ShipManager" %>

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
                    $('#MainContent_txtContact').val(data_row.ContactNumber);
                    document.getElementById("MainContent_ddlManager").value = data_row.SMangerId;
                    document.getElementById("MainContent_ddlshiptype").value = data_row.Type;
                    $('#MainContent_txtIMONo').val(data_row.IMONo);
                    $('#MainContent_txtDWT').val(data_row.DWT);
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
                location.href = "ShipMaster.aspx";
            });
        }
    </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
   <div>
        <div class="content-wrapper">
          <div class="row">            
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                  <h4 class="card-title">Ship Manager</h4> <br />
                <div class="card-body">
                  <h4 class="card-title">company's profile</h4> <br />                 
                    <label class="col-form-label text-danger" id="lblerror" runat="server"></label>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Company Name</label>
                          <div class="col-sm-8">                              
                              <input type="text" class="form-control" id="txtCompanyName" runat="server" placeholder="Company Name" required="required">
                      
                          </div>
                            <div class="col-sm-1">
                                <a href="#" class="" data-toggle="modal" data-target="#ShipModal" data-backdrop="static" data-keyboard="false" onclick="GetShipDetails();"><i class="fa fa-search"></i></a>
                                </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Address</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="txtAddress" runat="server" placeholder="Address" required="required">
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">General Phone No</label>
                          <div class="col-sm-9">                              
                              <input type="text" class="form-control" id="txtGeneralphno" runat="server" placeholder="Phone No" required="required">                      
                          </div>                            
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">FAX</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="txtFax" runat="server" placeholder="Fax" required="required">                              
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">POC Name</label>
                          <div class="col-sm-9">                              
                              <input type="text" class="form-control" id="txtPocName" runat="server" placeholder="POC Name" required="required">                      
                          </div>                            
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Personal Email</label>
                          <div class="col-sm-9">
                            <input type="Email" class="form-control" id="txtPEmail" runat="server" placeholder="Personal Email" required="required">                              
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Common Email</label>
                          <div class="col-sm-9">                              
                              <input type="Email" class="form-control" id="txtCEmail" runat="server" placeholder="Common Email" required="required">                      
                          </div>                            
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Direct Phone</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="txtDphone" runat="server" placeholder="Direct Phone" required="required">                              
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Mobile Phone</label>
                          <div class="col-sm-9">                              
                              <input type="text" class="form-control" id="txtMobilePhone" runat="server" placeholder="Mobile Phone" required="required">                      
                          </div>                            
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Company ID</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="txtCompanyId" runat="server" placeholder="Company ID" required="required">                              
                          </div>
                        </div>
                      </div>
                    </div><br />
                    <h4 class="card-title">Ship Details</h4> <br /><br />
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Ship Name</label>
                          <div class="col-sm-9">                              
                             <%-- <input type="text" class="form-control" id="txtName" runat="server" placeholder="Name" required="required"> --%> 
                              <select class="form-control" id="ddlShip" runat="server" required="required"> 
                                  </select>                    
                          </div>                            
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Ship Type</label>
                          <div class="col-sm-9">
                            <%--<input type="text" class="form-control" id="txtType" runat="server" placeholder="Ship Type" required="required">--%>
                              <select class="form-control" id="ddlshiptype" runat="server" required="required"> 
                                  <option value="Petroluem">Petroluem</option> 
                                   <option value="Chemical">Chemical</option> 
                                   <option value="LPG">LPG</option> 
                                   <option value="LNG">LNG</option> 
                                  <option value="Barge International">Barge International</option>                                          
                              </select>
                          </div>
                        </div>
                      </div>
                    </div>                    
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">IMO No</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="txtIMONo" runat="server" placeholder="IMO No" required="required">
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">DWT</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="txtDWT" placeholder="DWT" runat="server" required="required">
                          </div>
                        </div>
                      </div>
                    </div>                      
                    <div class="row">
                         <div class="col-md-8 offset-md-4">
                             <asp:Button Text="Submit" class="btn btn-primary mr-2" runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" />
                             <a class="btn btn-danger" href="ShipMaster.aspx">Cancel</a> 
                         </div>
                    </div>         
                </div>
              </div>
            </div>           
          </div>
            <div class="row hide">
                <div class="col-md-12 stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <p class="card-title">Company Details</p>
                            <div class="table-responsive">
                                <table id="recent-purchases-listing" class="table">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Address</th>
                                            <th>Location</th>
                                            <th>Size</th>
                                            <th>Date</th>                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Jeremy Ortega</td>
                                            <td>Levelled up</td>
                                            <td>Catalinaborough</td>
                                            <td>790</td>
                                            <td>06 Jan 2018</td>
                                           
                                        </tr>
                                        <tr>
                                            <td>Alvin Fisher</td>
                                            <td>Ui design completed</td>
                                            <td>East Mayra</td>
                                            <td>23230</td>
                                            <td>18 Jul 2018</td>
                                            
                                        </tr>
                                        <tr>
                                            <td>Emily Cunningham</td>
                                            <td>support</td>
                                            <td>Makennaton</td>
                                            <td>939</td>
                                            <td>16 Jul 2018</td>
                                            
                                        </tr>
                                        <tr>
                                            <td>Minnie Farmer</td>
                                            <td>support</td>
                                            <td>Agustinaborough</td>
                                            <td>30</td>
                                            <td>30 Apr 2018</td>
                                            
                                        </tr>
                                        <tr>
                                            <td>Betty Hunt</td>
                                            <td>Ui design not completed</td>
                                            <td>Lake Sandrafort</td>
                                            <td>571</td>
                                            <td>25 Jun 2018</td>
                                           
                                        </tr>
                                        <tr>
                                            <td>Myrtie Lambert</td>
                                            <td>Ui design completed</td>
                                            <td>Cassinbury</td>
                                            <td>36</td>
                                            <td>05 Nov 2018</td>                                           
                                        </tr>                                       
                                    </tbody>
                                </table>
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
