<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User.aspx.cs" MasterPageFile="~/Site.Master" Inherits="E_Inspection.Forms.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%= Page.ResolveClientUrl("~/scripts/jquery-3.3.1.min.js") %>"></script>
    <script type="text/javascript">

        function GetUserDetails() {
            $.ajax({
                type: "POST",
                url:'<%=ResolveUrl("User.aspx/GetUserDetails") %>',
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
            var dt = $('#Usertable').DataTable({
                data: jsondata.Manager,
                destroy: true,
                "columns": [
                    {
                        "class": "edit_btn",
                        "mRender": function (data, type, row) {
                            return '<a  href="javascript: void (0);" data-dismiss="modal" aria-label="Close">' + row.UserId + '</a > ';

                        }
                    },
                    { "data": "UserName" },
                    { "data": "Type" },
                    { "data": "ContactNumber" }
                ]
            });
            $('#Usertable').on('click', 'tbody .edit_btn', function () {
                var data_row = dt.row($(this).closest('tr')).data();
                if (data_row) {
                    $('#MainContent_txtUserID').val(data_row.UserId);
                    $('#MainContent_txtName').val(data_row.UserName);
                    $('#MainContent_ddlUserType')[0].value = data_row.UserType;
                    $('#MainContent_txtContact').val(data_row.ContactNumber); 
                    $('#MainContent_txtAddress').val(data_row.Address);                  
                    $('#MainContent_txtEmail').val(data_row.EmailId);
                    $('#MainContent_password1').val(data_row.Password);
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
                location.href = "User.aspx";
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
                  <h4 class="card-title">USER</h4>
                <div class="card-body">
                   <br />                 
                    <label class="col-form-label text-danger" id="lblerror" runat="server"></label>
                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Name</label>
                          <div class="col-sm-8">
                              <input type="text" class="form-control" runat="server" id="txtUserID" placeholder="" style="display:none;">
                            <input type="text" class="form-control" id="txtName" runat="server" placeholder="Name" required="required">
                      
                      </div>
                            <div class="col-sm-1">
                                <a href="#" class="" data-toggle="modal" data-target="#UserModal" data-backdrop="static" data-keyboard="false" onclick="GetUserDetails();"><i class="fa fa-search"></i></a>
                                </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">User Type</label>
                          <div class="col-sm-9">
                           <select class="form-control" id="ddlUserType" runat="server" required="required">                                        
                           </select>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Email</label>
                          <div class="col-sm-9">
                            <input type="email" class="form-control" placeholder="XXXXX@XX.com" name="Email" runat="server" id="txtEmail">
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Password</label>
                          <div class="col-sm-9">
                            <input type="password" class="form-control" placeholder="******" name="Password" runat="server" id="password1" required="required">
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Address</label>
                          <div class="col-sm-9">
                              <textarea class="form-control" id="txtAddress" rows="4" runat="server" placeholder="Address" required="required"></textarea>                            
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Contact</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="txtContact" runat="server" placeholder="Contact" required="required">
                          </div>
                        </div>
                      </div>
                    </div>      
                    <div class="row">
                         <div class="col-md-8 offset-md-4">                                                    
                    <asp:Button Text="Submit" class="btn btn-primary mr-2" runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" />
                    <a class="btn btn-danger" href="User.aspx">Cancel</a> 
                             </div>
                        </div>                
                </div>
              </div>
            </div>           
          </div>            
          </div>
      </div>
    <div class="modal fade" id="UserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 130%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">User Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="Usertable" width="100%">
                                <thead>
                                    <tr>
                                        <th>User ID</th>
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
