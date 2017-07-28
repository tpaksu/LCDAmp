program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  System2 in 'System2.pas',
  adCpuUsage in 'adCpuUsage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PicAmp';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
