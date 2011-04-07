; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#include "InnoScripts\IISUtils.iss"
#include "InnoScripts\VcRuntimeInstalled.iss"


[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
ArchitecturesInstallIn64BitMode=x64 ia64
AppId={{995D337A-5620-4537-9704-4B19EC628A39}
AppName=Direct Project .NET Gateway
AppVerName=Direct Project .NET Gateway 1.0.0.0
AppPublisher=The Direct Project (nhindirect.org)
AppPublisherURL=http://nhindirect.org
AppSupportURL=http://nhindirect.org
AppUpdatesURL=http://nhindirect.org
DefaultDirName={pf}\Direct Project .NET Gateway
DefaultGroupName=Direct Project .NET Gateway
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename=Direct-1.0.0.0-NET35
Compression=lzma
SolidCompression=yes
VersionInfoVersion=1.0.0.0
SetupLogging=yes

WizardImageFile=Direct.bmp
WizardSmallImageFile=DirectSmall.bmp
WizardImageStretch=Yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Components]
Name: dnsresponder; Description: Install the DNS Responder; Types: development dns; 
Name: dnswebservice; Description: DNS Web service; Types: development config; 
Name: configwebservice; Description: Config Web service; Types: development config; 
Name: configui; Description: Config UI Admin; Types: development config;
Name: directgateway; Description: Gateway to SMTP; Types: development gateway; 
Name: developergateway; Description: Developer gateway configuration to SMTP; Types: development; 
Name: database; Description: DirectConfig database; Types: development database;


[Types]
Name: gateway; Description: Gateway               
Name: dns; Description: DNS Responder; 
Name: config; Description: Config services             
Name: database; Description: Database
Name: custom; Description: Custom Install; Flags: iscustom;
Name: development; Description: Developer Install (Single machine and development gateway version)


[Files]
Source: "..\bin\debug\*.dll"; DestDir: "{app}"; Flags: ignoreversion;  Components: dnsresponder dnswebservice configwebservice configui directgateway developergateway; 
Source: "..\bin\debug\Win32\smtpEventHandler.dll"; DestDir: "{app}"; Flags: ignoreversion; Check: IsX86;  Components: dnsresponder dnswebservice configwebservice configui directgateway developergateway; 
Source: "..\bin\debug\x64\smtpEventHandler.dll"; DestDir: "{app}"; Flags: ignoreversion; Check: IsX64 or IsIA64; Components: dnsresponder dnswebservice configwebservice configui directgateway developergateway;                            
Source: "..\bin\debug\*.config"; DestDir: "{app}"; Excludes: "*.vshost.*,*.dll.config"; Flags: ignoreversion; Components: dnsresponder dnswebservice configwebservice configui directgateway developergateway; 
Source: "..\bin\debug\*.exe"; DestDir: "{app}"; Excludes: "*.vshost.*"; Flags: ignoreversion; Components: dnsresponder dnswebservice configwebservice configui directgateway developergateway; 
Source: "..\bin\debug\Certificates\*"; DestDir: "{app}\Certificates"; Flags: ignoreversion recursesubdirs;   Components: developergateway; 
Source: "..\bin\debug\ConfigConsoleSettings.xml"; DestDir: "{app}"; Flags: ignoreversion; Components: developergateway

Source: "..\config\service\*.svc"; DestDir: "{app}\ConfigService"; Flags: ignoreversion; Components: configwebservice; 
Source: "..\config\service\*.aspx"; DestDir: "{app}\ConfigService"; Flags: ignoreversion; Components: configwebservice; 
Source: "..\config\service\*.config"; DestDir: "{app}\ConfigService"; Flags: ignoreversion; Components: configwebservice; 
Source: "..\config\service\bin\*.dll"; DestDir: "{app}\ConfigService\bin"; Flags: ignoreversion recursesubdirs; Components: configwebservice; 

Source: "..\dnsresponder.service\*.svc"; DestDir: "{app}\DnsService"; Flags: ignoreversion; Components: dnswebservice; 
Source: "..\dnsresponder.service\*.aspx"; DestDir: "{app}\DnsService"; Flags: ignoreversion; Components: dnswebservice; 
Source: "..\dnsresponder.service\*.config"; DestDir: "{app}\DnsService"; Flags: ignoreversion; Components: dnswebservice; 
Source: "..\dnsresponder.service\bin\*.dll"; DestDir: "{app}\DnsService\bin"; Flags: ignoreversion recursesubdirs; Components: dnswebservice; 

Source: "configui\*"; DestDir: "{app}\ConfigUI"; Flags: ignoreversion recursesubdirs; Components: configui; 

Source: "..\gateway\install\*.vbs"; DestDir: "{app}"; Flags: ignoreversion; Components: directgateway;
Source: "..\gateway\install\*.bat"; DestDir: "{app}"; Excludes: "backup.bat,copybins.bat"; Flags: ignoreversion; Components: directgateway;
Source: "SmtpAgentConfig.xml"; DestDir: {app}; Flags: ignoreversion; Components: directgateway;

Source: "..\gateway\devInstall\DevAgentWithServiceConfig.xml"; DestDir: "{app}"; DestName: "DevAgentConfig.xml"; Flags: ignoreversion; Components: developergateway;            
Source: "..\gateway\devInstall\setupdomains.txt"; DestDir: "{app}"; Flags: ignoreversion; Components: developergateway;
Source: "..\gateway\devInstall\simple.eml"; DestDir: "{app}\Samples"; Flags: ignoreversion; Components: developergateway;

Source: "..\external\microsoft\vcredist\vcredist_x86.exe"; DestDir: "{app}\Libraries"; DestName: "vcredist.exe"; Flags: ignoreversion recursesubdirs; Check: IsX86; Components: directgateway developergateway;
Source: "..\external\microsoft\vcredist\vcredist_x64.exe"; DestDir: "{app}\Libraries"; DestName: "vcredist.exe"; Flags: ignoreversion recursesubdirs; Check: IsX64 or IsIA64; Components: directgateway developergateway;

Source: "*.bat"; DestDir: "{app}"; Excludes: "build-installer.bat"; Flags: ignoreversion;
Source: "*.ps1"; DestDir: "{app}"; Flags: ignoreversion;
Source: "event-sources.txt"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\config\store\Schema.sql"; DestDir: "{app}\SQL"; Flags: ignoreversion; Components: database; 
Source: "createuser.sql"; DestDir: "{app}\SQL"; Flags: ignoreversion; Components: database; 
                        
Source: "toolutil\install.tools\bin\debug\Health.Direct.Install.Tools.dll"; DestDir: "{app}\InstallTools"; Flags: ignoreversion;  Components: dnsresponder and not developergateway;  

                                 
[UninstallDelete]
Type: files; Name: "{app}\direct.ini"
Type: files; Name: "{app}\Health.Direct.SmtpAgent.tlb"
Type: files; Name: "{app}\InstallationLogFile.log"
Type: files; Name: "{app}\installdnsresponder.log"
Type: files; Name: "{app}\installgateway.log"
Type: files; Name: "{app}\createeventlogsource.log"
Type: files; Name: "{app}\InstallTools\Health.Direct.Install.Tools.tlb"

[Icons]
Name: "{group}\Admin Console"; Filename: "{app}\AdminConsole.exe"; WorkingDir: "{app}";
Name: "{group}\Config Console"; Filename: "{app}\ConfigConsole.exe"; WorkingDir: "{app}";
Name: "{group}\Config Web UI"; Filename: "http://localhost/ConfigUI/";
Name: "{group}\Test Database"; Filename: "http://localhost/ConfigService/TestService.aspx";
Name: "{group}\{cm:UninstallProgram,Direct Gateway}"; Filename: "{uninstallexe}";


[Run]
Filename: {app}\Libraries\vcredist.exe; Description: "Microsoft Visual C++ 2008 Redistributable Package"; Flags: postinstall runascurrentuser unchecked; Components: directgateway or developergateway; Check: not IsVCRT
Filename: {app}\createdatabase.bat; Parameters: ".\sqlexpress DirectConfig ""{app}\SQL\Schema.sql"" ""{app}\SQL\createuser.sql"""; Description: Install Database; Flags: runascurrentuser postinstall; Components: developergateway and not database;
Filename: {app}\createdatabase.bat; Parameters: ".\sqlexpress DirectConfig ""{app}\SQL\Schema.sql"" ""{app}\SQL\createuser.sql"""; Description: Install Database; Flags: runascurrentuser; Components: database;
Filename: {app}\install-dev.bat; Parameters: """{app}"""; Description: "Install Gateway (DEVELOPMENT VERSION)"; WorkingDir: "{app}"; Flags: postinstall runascurrentuser unchecked; Components: developergateway;
Filename: {app}\installdnsresponder.bat; Parameters: """{app}"" >> ""{app}\installdnsresponder.log"" 2>&1"; Description: Install DNS Responder; Flags: runascurrentuser ; Components: dnsresponder and not developergateway; 
Filename: {dotnet20}\RegAsm.exe; Parameters: Health.Direct.Install.Tools.dll /codebase; WorkingDir:{app}\InstallTools; StatusMsg: Installing installer tools; Description: Register tool com visible; Flags: runascurrentuser; Components: dnsresponder and not developergateway;
Filename: {app}\installgateway.bat; Parameters:  """{app}"" >> ""{app}\installgateway.log"" 2>&1";  Description: Install Gateway; Flags: runascurrentuser ; Components: directgateway and not developergateway; 
Filename: {app}\createadmin.bat; Description:Create Admin.  (Database must exist); Flags: runascurrentuser postinstall unchecked; Components: not developergateway; 
Filename: {app}\createeventlogsource.bat; Parameters: " >> ""{app}\createeventlogsource.log"" 2>&1"; Description:Setup event log; Flags: runascurrentuser; Components: not developergateway; 


[UninstallRun]
Filename: {app}\uninstall.bat; Flags: runascurrentuser; RunOnceId: 'RemoveDeveloperGateway';   Components: developergateway;
Filename: {app}\uninstallDnsResponder.bat; RunOnceId: 'RemoveDnsResponder';  Components: dnsresponder and not developergateway;
Filename: {app}\uninstallGateway.bat; RunOnceId: 'RemoveGateway'; Components: directgateway and not developergateway;
Filename: {dotnet20}\RegAsm.exe; RunOnceId: 'Removeinstall.tools'; Parameters: Health.Direct.Install.Tools.dll /unregister; WorkingDir:{app}\InstallTools; Flags: runascurrentuser; Components: dnsresponder and not developergateway;


[INI]
Filename: {app}\direct.ini; section: InstallSettings; key: "DnsWebService_Vdir"; string: DnsService; Components: dnswebservice
Filename: {app}\direct.ini; section: InstallSettings; key: "ConfigWebService_Vdir"; string: ConfigService; Components: configwebservice
Filename: {app}\direct.ini; section: InstallSettings; key: ConfigUiWebApp_Vdir; string: ConfigUI; Components: configui



[Code]



//Log file maintenance
var
  OkToCopyLog : Boolean;



function IsX64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paX64);
end;

function IsIA64: Boolean;
begin
  Result := Is64BitInstallMode and (ProcessorArchitecture = paIA64);
end;

function IsX86: Boolean;
begin
  Result := (ProcessorArchitecture = paX86);
end;

//included script to test for VC redistributable
function IsVCRT: Boolean;
begin
  Result := VCRT_IsInstalled (VC2008_ANY_x64) = 5;
end;

procedure CheckDnsResponderServiceOnClick(Sender: TObject);
var
  ErrorCode: Integer;
  Button: TButton;
  DnsServiceTestTextBox: TNewEdit;
  DnsResponderPage: TWizardPage;
begin
  Button := TButton(Sender);
  DnsResponderPage := TWizardPage(Button.Owner);
  DnsServiceTestTextBox := TNewEdit(DnsResponderPage.FindComponent('DnsServiceTestTextBox'));
  ShellExecAsOriginalUser('open', DnsServiceTestTextBox.Text, '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure SetDnsResponderUrl(url: String);
var
  XpathTools: Variant;
begin
  try                              
    XpathTools := CreateOleObject('Direct.XpathTools');
  except
    RaiseException('Cannot find Direct.XpathTools.'#13#13'(Error ''' + GetExceptionMessage + ''' occurred)');
  end;
    XpathTools.XmlFilePath := ExpandConstant('{app}') + '\DirectDnsResponderSvc.exe.config' ;
    XpathTools.SetSingleAttribute('/configuration/ServiceSettingsGroup/RecordRetrievalServiceSettings/@Url', url);
end;

function SetDnsResponderUrlOnClick(Sender: TWizardPage): Boolean;
var
  DnsServiceUrlLabel : TNewStaticText;
begin         
    DnsServiceUrlLabel := TNewStaticText(Sender.FindComponent('DnsServiceUrlLabel'));
    SetDnsResponderUrl(DnsServiceUrlLabel.Caption);
    Result := True;
end;

function GetDnsResponderUrl(): String;
var
  XpathTools: Variant; 
  dnsResponderUrl: String;
begin
  try                              
    XpathTools := CreateOleObject('Direct.XpathTools');
  except
    RaiseException('Cannot find Direct.XpathTools.'#13#13'(Error ''' + GetExceptionMessage + ''' occurred)');
  end;
    XpathTools.XmlFilePath := ExpandConstant('{app}') + '\DirectDnsResponderSvc.exe.config' ;
    dnsResponderUrl := XpathTools.SelectSingleAttribute('/configuration/ServiceSettingsGroup/RecordRetrievalServiceSettings/@Url');
    Result := dnsResponderUrl;
end;


procedure HostNameOnChange(Sender: TObject);
var
  tools : Variant;
  DnsServiceUrlLabel, ErrorLabel : TNewStaticText;
  DnsServiceTestTextBox : TNewEdit;
  DnsResponderPage : TWizardPage;
  hostport : String;
begin
  DnsServiceTestTextBox := TNewEdit(Sender); 
  DnsResponderPage := TWizardPage(DnsServiceTestTextBox.Owner)
  ErrorLabel := TNewStaticText(DnsResponderPage.FindComponent('ErrorLabel'));
  ErrorLabel.Caption := '';
     
  //Update DnsService (Will be persisted to config file when finished with wizard) 
  try                              
    tools := CreateOleObject('Direct.UrlTools');
  except
    RaiseException('Cannot find Direct.UrlTools.'#13#13'(Error ''' + GetExceptionMessage + ''' occurred)');
  end;  
  
    
 if(tools.ValidUrl(DnsServiceTestTextBox.Text)) then
 begin  
  DnsServiceUrlLabel := TNewStaticText(DnsResponderPage.FindComponent('DnsServiceUrlLabel'));  
  hostPort :=  tools.HostPort(DnsServiceTestTextBox.Text); 
  DnsServiceUrlLabel.Caption :=  tools.UpdateUrlHost(DnsServiceUrlLabel.Caption, hostport).FullUrl 
 end         
 else
 begin
    ErrorLabel.Caption := 'Invalid Url.';
 end;
end;



procedure DnsResponderPageOnActivate(Sender: TWizardPage);
var
  tools : Variant;
  DnsServiceUrlLabel : TNewStaticText;
  hostPort : String;   //both host and port; locahost:80
  DnsServiceTestTextBox : TNewEdit;
begin
  //Set DnsService from config file.
  DnsServiceUrlLabel := TNewStaticText(Sender.FindComponent('DnsServiceUrlLabel'));
  DnsServiceUrlLabel.Caption :=   GetDnsResponderUrl();
  
  //Set TestService.aspx by rebuilding Url 
  try                              
    tools := CreateOleObject('Direct.UrlTools');
  except
    RaiseException('Cannot find Direct.UrlTools.'#13#13'(Error ''' + GetExceptionMessage + ''' occurred)');
  end;  
  DnsServiceTestTextBox := TNewEdit(Sender.FindComponent('DnsServiceTestTextBox')); 
  hostPort :=  tools.HostPort(DnsServiceUrlLabel.Caption); 
  DnsServiceTestTextBox.Text :=  tools.Scheme(DnsServiceUrlLabel.Caption) 
  + '://'
  + hostPort
  + '/DnsService/TestService.aspx'; 

  
end;

function DnsResponderPage_ShouldSkip(Page: TwizardPage): Boolean;
begin
  Result := (pos( 'dnsresponder', WizardSelectedComponents( false)) = 0) ;
end;

function MsSmtpServiceExists(Host: String; Port: Integer): Boolean;
var
      SmtpExists: Boolean;
      SmtpTools: Variant;
begin
  try                              
    SmtpTools := CreateOleObject('Direct.SmtpTools');
  except
    RaiseException('Cannot find Direct.SmtpTools.'#13#13'(Error ''' + GetExceptionMessage + ''' occurred)');
  end;
    try
      Log('Checking Smtp connection with host:port of ' + Host + ':' + IntToStr(Port)); 
      SmtpExists := SmtpTools.TestConnection(Host, Port);
    except
      Log('Error: ' + GetExceptionMessage);       
    end
    Result := SmtpExists;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
 begin
  if(CurPageID = wpReady) then 
    begin
      //check for smtp
      if (pos( 'directgateway', WizardSelectedComponents( false)) > 0)  or (pos( 'development', WizardSetupType( false)) > 0) then  
      begin
          if not (MsSmtpServiceExists('LocalHost', 25)) then 
          begin
            MsgBox('Failed to find smtp running.', mbInformation, mb_Ok);
            Result := False;
          end 
          else begin
            Result := True;
          end;
      end
      else begin
        Result := True;
      end;   
    end    
    else begin
      Result := True;
    end;    
end;

procedure DnsServiceUrlOnClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExecAsOriginalUser('open', TNewStaticText(Sender).Caption, '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure CreateTheWizardPages;
var
  DnsResponderPage: TWizardPage;
  DnsServiceTestTextBox: TNewEdit;
  Button: TNewButton;
  DnsServiceLabel, DnsServiceUrlLabel : TNewStaticText;
  ErrorLabel : TNewStaticText;
begin

  DnsResponderPage := CreateCustomPage(wpInfoAfter, 'Configure DnsResponder', 'DnsService endpoint stored in DirectDnsResponderSvc.exe.config');
    
  Button := TNewButton.Create(DnsResponderPage);
  Button.Height :=  ScaleY(23);
  Button.Width := DnsResponderPage.SurfaceWidth div 3;
  Button.Caption := 'Dns DB Connect Test: ';
  Button.OnClick := @CheckDnsResponderServiceOnClick;
  Button.Parent := DnsResponderPage.Surface;
  
  DnsServiceTestTextBox := TNewEdit.Create(DnsResponderPage);
  DnsServiceTestTextBox.Name := 'DnsServiceTestTextBox';
  DnsServiceTestTextBox.Left :=  Button.Width + ScaleX(8);
  DnsServiceTestTextBox.Width := DnsResponderPage.SurfaceWidth - (Button.Left + Button.Width);
  DnsServiceTestTextBox.Parent := DnsResponderPage.Surface;
  DnsServiceTestTextBox.OnChange := @HostNameOnChange;
            
  DnsServiceLabel := TNewStaticText.Create(DnsResponderPage);
  DnsServiceLabel.Top := DnsServiceTestTextBox.Top + DnsServiceTestTextBox.Height + ScaleY(16); 
  DnsServiceLabel.Caption := 'DnsService endpoint: ';
  DnsServiceLabel.Width := Button.Width;
  DnsServiceLabel.Parent := DnsResponderPage.Surface;

  DnsServiceUrlLabel := TNewStaticText.Create(DnsResponderPage);
  DnsServiceUrlLabel.Name := 'DnsServiceUrlLabel';
  DnsServiceUrlLabel.Cursor := crHand;
  DnsServiceUrlLabel.OnClick := @DnsServiceUrlOnClick;
  DnsServiceUrlLabel.Left := Button.Width + ScaleX(8);
  DnsServiceUrlLabel.Top := DnsServiceTestTextBox.Top + DnsServiceTestTextBox.Height + ScaleY(16);
  DnsServiceUrlLabel.Width := DnsResponderPage.SurfaceWidth - ScaleX(8);
  DnsServiceUrlLabel.Font.Style := DnsServiceUrlLabel.Font.Style + [fsUnderline];
  DnsServiceUrlLabel.Font.Color := clBlue;
  DnsServiceUrlLabel.Parent := DnsResponderPage.Surface;

  ErrorLabel := TNewStaticText.Create(DnsResponderPage);
  ErrorLabel.Name := 'ErrorLabel';
  ErrorLabel.Top := DnsResponderPage.SurfaceHeight - ScaleY(16);
  ErrorLabel.Font.Color := clRed;
  ErrorLabel.Parent := DnsResponderPage.Surface;

  DnsResponderPage.OnActivate := @DnsResponderPageOnActivate;
  DnsResponderPage.OnNextButtonClick := @SetDnsResponderUrlOnClick;
  DnsResponderPage.OnShouldSkipPage := @DnsResponderPage_ShouldSkip;
end;


//Create Virtual directories
procedure CurStepChanged(CurStep: TSetupStep);
          
begin
  
  //Post install step
  if (CurStep = ssPostInstall) then begin
    //Dns web service somponent selected and Not installing development type
    if (pos( 'dnswebservice', WizardSelectedComponents( false)) > 0) and (pos( 'development', WizardSetupType( false)) = 0) then  
      begin
        CreateIISVirtualDir('DnsService', ExpandConstant('{app}') + '\DnsService', 'Direct DNS Responder Service');
      end; 
    //Config web service component selected and Not installing development type
    if (pos( 'configwebservice', WizardSelectedComponents( false)) > 0)  and (pos( 'development', WizardSetupType( false)) = 0) then  
      begin
        CreateIISVirtualDir('ConfigService', ExpandConstant('{app}') + '\ConfigService', 'Direct Config Service');
      end;
    //Config UI web application component selected and Not installing development type
    if (pos( 'configui', WizardSelectedComponents( false)) > 0)  and (pos( 'development', WizardSetupType( false)) = 0) then  
      begin
        CreateIISVirtualDir('ConfigUI', ExpandConstant('{app}') + '\ConfigUI', 'Direct Config Admin');
      end;
   // Exec('IISReset');
  end;
  //Log file maintenance
  if CurStep = ssDone then
    OkToCopyLog := True;


end;



//Remove Virtual directories.
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  DnsWebService_Vdir, ConfigWebService_Vdir, ConfigUiWebApp_Vdir: String;
begin
  
  //Post install step
  if (CurUninstallStep = usUninstall) then begin

    DnsWebService_Vdir := GetIniString('InstallSettings', 'DnsWebService_Vdir', 'unknown', ExpandConstant('{app}') + '\direct.ini');
    ConfigWebService_Vdir := GetIniString('InstallSettings', 'ConfigWebService_Vdir', 'unknown', ExpandConstant('{app}') + '\direct.ini');
    ConfigUiWebApp_Vdir := GetIniString('InstallSettings', 'ConfigUiWebApp_Vdir', 'unknown', ExpandConstant('{app}') + '\direct.ini')


    //Dns web service somponent selected and Not installing development type
    if not (CompareStr('unknown', DnsWebService_Vdir) = 0)  then  
      begin
        DeleteIISVirtualDir(DnsWebService_Vdir);
      end; 
    //Config web service component selected and Not installing development type
    if not (CompareStr('unknown', ConfigWebService_Vdir) = 0)  then  
      begin
        DeleteIISVirtualDir(ConfigWebService_Vdir);
      end;
    //Config UI web application component selected and Not installing development type
    if not (CompareStr('unknown', ConfigUiWebApp_Vdir) = 0)  then  
      begin
        DeleteIISVirtualDir(ConfigUiWebApp_Vdir);
      end;
  end;
end;


procedure DeinitializeSetup();
begin
  if OkToCopyLog then
    FileCopy (ExpandConstant ('{log}'), ExpandConstant ('{app}\InstallationLogFile.log'), FALSE);
    RestartReplace (ExpandConstant ('{log}'), '');   // remove the temp log file during the next system restart.
end;

procedure InitializeWizard;
begin

  CreateTheWizardPages;

end;



