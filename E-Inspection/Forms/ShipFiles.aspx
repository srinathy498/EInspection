<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShipFiles.aspx.cs" MasterPageFile="~/Site.Master" Inherits="E_Inspection.Forms.ShipFiles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="<%= Page.ResolveClientUrl("~/scripts/jquery-3.3.1.min.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var userType = '<%= Session["UserType"] %>';
            if (userType != "3" && userType != "1")
            {
                $('#divShip').css('display', 'none');
            }
            
        });
        function GetShipFileDetails() {
            $.ajax({
                type: "POST",
                url: '<%=ResolveUrl("ShipFiles.aspx/GetShipFileDetails") %>',
                data: '{ UserId:"' + '' + '" , ShipId: "' + $('#MainContent_ddlship').val() + '"}',
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
                data: jsondata.ShipFiles,
                destroy: true,
                "columns": [                    
                    {"data":"UserName"},
                    { "data": "Name" },
                    { "data": "FileType" },
                    { "data": "FileName" },
                    {
                        "class": "pdf",
                        "mRender": function (data, type, row) {
                            return ' <button type="button" class="btn btn-primary" onclick=OpenFile("' + row.Path.replace(/ /g, '^') + '")>' +
                                'Download' +
                                ' </button>';
                        }
                    }
                                                          
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
                    //$('#MainContent_btnSubmit')[0].innerText = "Update";
                    //$('#MainContent_btnSubmit')[0].value = "Update";
                    //$('#MainContent_btnhdn')[0].value = "Update";

                }
            });
        }
        function successalert(msginfo) {
            swal({
                text: msginfo,
                type: 'success'
            }).then(function () {
                location.href = "ShipFiles.aspx";
            });
        }
       function OpenFile(path)
        {
            path = path.replace('^', ' ')
            var a = document.createElement('A');
            var filePath ="../"+path;
            a.href = filePath;
            //a.download = filePath.substr(filePath.lastIndexOf('/') + 1);
            //document.body.appendChild(a);
            //a.click();
            a.setAttribute('target', '_blank');
            a.click();
            //document.body.removeChild(a);
        }
    </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
   <div>
        <div class="content-wrapper">
          <div class="row">            
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                  <h4 class="card-title">SHIP Files</h4>
                <div class="card-body">
                   <br />                 
                    <label class="col-form-label text-danger" id="lblerror" runat="server"></label> 
                    
                    <div class="row">
                      <div class="col-md-6" id="divShip">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Ship Name</label>
                          <div class="col-sm-8">
                            <select class="form-control" id="ddlship" runat="server" required="required">                                                            
                            </select>
                          </div>
                            <div class="col-sm-1">
                                <a href="#" class="" data-toggle="modal" data-target="#ShipModal" data-backdrop="static" data-keyboard="false" onclick="GetShipFileDetails();"><i class="fa fa-search"></i></a>
                                </div>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Type of Files</label>
                          <div class="col-sm-9">
                         <select class="form-control" id="ddlTypeFiles" runat="server" required="required"> 
                        <option value="Officer/Crew certificate">Officer/Crew certificate</option> 
                        <option value="Training records">Training records</option>
                        <option value="Ship Certificates">Ship Certificates</option>
                        <option value="Test Records">Test Records</option>
                        <option value="Procedure">Procedure</option>
                        <option value="Maintenance records">Maintenance records</option>
                        <option value="Ship Test Records">Ship Test Records</option>
                        <option value="E-Docs">E-Docs</option>
                        <option value="Photos">Photos</option>
                        <option value="Document Exceprt">Document Exceprt</option>
                        <option value="Video">Video</option>
                        <option value="Charts">Charts</option>
                        <option value="Voice Records">Voice Records</option></select>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group row">
                          <label class="col-sm-3 col-form-label">Multiple File Upload</label>
                          <div class="col-sm-9">
                            <asp:FileUpload ID="shipfileupload" runat="server" AllowMultiple="true" />  
                          </div>
                        </div>
                      </div>                      
                    </div>    
                    <div class="row">
                         <div class="col-md-8 offset-md-4">        
                    <asp:Button Text="Submit" class="btn btn-primary mr-2" runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" />
                    <a class="btn btn-danger" href="ShipFiles.aspx">Cancel</a>    
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
                <div class="modal-content" style="width: 170%;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ship Files Details</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="Shiptable" width="100%">
                                <thead>
                                    <tr>                                           
                                        <th>User Name</th>
                                        <th>Ship Name</th>
                                        <th>Type</th>
                                        <th>File Name</th>   
                                        <th></th>              
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
