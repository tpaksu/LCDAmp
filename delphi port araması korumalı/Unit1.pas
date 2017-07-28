unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinampControl, StdCtrls, ActnMan, ActnColorMaps, ComCtrls,
  ExtCtrls, Buttons, Grids, DirOutln,StrUtils, CPortCtl, CPort,
  System2, adCpuUsage;

type
  TForm1 = class(TForm)
    WC1: TWinampControl;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    Timer2: TTimer;
    Timer3: TTimer;
    shifttimer: TTimer;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ComPort1: TComPort;
    Label8: TLabel;
    Edit1: TEdit;
    ComComboBox1: TComComboBox;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure b4mousedown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure b4mouseup(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn5mousedown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer3Timer(Sender: TObject);
    procedure btn5mouseup(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure shifttimerTimer(Sender: TObject);
    procedure OnClose(Sender: TObject; var Action: TCloseAction);
    procedure rxchar(Sender: TObject; Count: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure comcombochange(Sender: TObject);


  private
    { Private declarations }
  public
  adim : integer;
  temp : string;
  shift : integer;
  kaydir : shortint;
  shift2 : integer;
  kaydir2 : shortint;
  lcdccnt : integer;
  end;

var
  Form1: TForm1;
  system1:Tsystem;

implementation

{$R *.dfm}



function saniyecevir(saniye:integer) : string;
var san,dak,zaman : string;
begin
san:=inttostr(saniye mod 60);
dak:=inttostr((saniye - (saniye mod 60)) div 60);
if length(dak)=1 then dak:='0'+dak;
if length(san)=1 then san:='0'+san;
zaman:= dak + ':' + san;
result:= zaman;
end;

function salisecevir(offset:integer) : string;
var saniye : integer;
var temp :string;
begin
temp:=inttostr(offset);
insert(',', temp, length(temp)-5);
saniye:=StrToInt(FloatToStr(round(strtofloat(temp))));
result:= saniyecevir(saniye);
end;


function basharfbuyut(yazi : string) : string;
var i : integer;
var temp : string;
begin
yazi:=' ' + yazi;
for i:=1 to length(yazi) do
begin
if (AnsiMidStr(yazi,i-1,1)=' ') then temp:=temp + uppercase(AnsiMidStr(yazi,i,1))
else temp:=temp+AnsiMidStr(yazi,i,1)
end;
result:=trim(temp);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var artist,song,fulltitle : ansistring;
var ram,cpu : extended;
begin
if wc1.IsPlaying or wc1.IsPaused then
begin
CollectCpuData;
Cpu := round(GetCPUUsage(GetCpuCount-1)*100);
Ram := round(100 - ((system1.availPhysmemory / system1.totalPhysmemory)*100));
label8.Caption:='CPU:' + floattostr(cpu) + '%' + dupestring(' ',20-length(floattostr(cpu))-length(floattostr(ram))-10) + 'RAM:' + floattostr(ram) + '%';
if label3.Caption <> wc1.GetTrackTitle then
begin
shift:=0;
label3.Caption:=StringReplace(wc1.GetTrackTitle,'&','&&',[RfReplaceAll]);
fulltitle := label3.Caption;
if AnsiContainsStr(fulltitle,'-') then
begin
artist := LeftStr(fulltitle,AnsiPos(' - ',fulltitle));
song := RightStr(fulltitle,Length(fulltitle)-Ansipos(' - ',fulltitle)-2);
label1.caption:=basharfbuyut(trim(artist));
label4.caption:=basharfbuyut(trim(song));
end
else
begin
label1.Caption:='(bilinmeyen)';
label4.caption:=AnsiMidStr(basharfbuyut(trim(fulltitle)),shift,20);
end;
label2.Caption:=salisecevir(wc1.getoffset+1000)+'/'+saniyecevir(wc1.getlength)+' '+inttostr(wc1.GetBitrate)+'k' ;
end
else
begin
label2.caption:=salisecevir(wc1.GetOffset)+'/'+saniyecevir(wc1.getlength)+' '+inttostr(wc1.GetBitrate)+'k';
end;
if wc1.IsPaused then
begin
label2.Caption:='';
if strtoint(rightstr(timetostr(time),2)) mod 2 = 0 then label2.Caption:='';
if strtoint(rightstr(timetostr(time),2)) mod 2 = 1 then label2.Caption:=temp;
end;

end
else
begin
shift:=0;
label1.Caption:='';
label2.Caption:='';
label4.Caption:='';
label3.Caption:='';
label8.Caption:='';
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
wc1.StartPlay
end;

procedure TForm1.Button3Click(Sender: TObject);

begin
temp := label2.caption;
label2.Caption:='';
wc1.Pause;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
wc1.Stop;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
wc1.PrevTrack;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
wc1.NextTrack;
end;


procedure TForm1.b4mousedown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   timer2.interval:=500;
   timer2.Enabled:=true;
end;

procedure TForm1.b4mouseup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
timer2.Interval:=500;
timer2.Enabled:=false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);

begin
wc1.VolumeUp;


if timer2.Interval>50 then timer2.Interval:=timer2.Interval-75;

end;



procedure TForm1.btn5mousedown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
timer3.interval:=500;
timer3.Enabled:=true;
end;

procedure TForm1.btn5mouseup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
timer3.interval:=500;
timer3.Enabled:=false;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
wc1.VolumeDown;
if timer3.Interval>50 then timer3.Interval:=timer3.Interval-75;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
wc1.VolumeUp;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
wc1.VolumeDown;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin


  EnumComPorts(ComComboBox1.Items);


adim:=2;
lcdccnt:=20;
kaydir:=0;
kaydir2:=0;
shift:=0;
shift2:=0;

  if ComComboBox1.items[0]<>'' then
  begin
    ComPort1.Port := ComComboBox1.Items[0];
    comcombobox1.Text:=comcombobox1.Items[0];
    shifttimer.Enabled:=true;
    end
  else
  begin
    showmessage('Bilgisayarýnýzda Seri Port Bulunamadý.');
    halt(4);
  end;


end;

procedure TForm1.shifttimerTimer(Sender: TObject);
var stra : string;
begin
if length(label4.Caption)>lcdccnt then
begin
label5.Caption:=ansiMidStr(label4.caption,shift,lcdccnt);
if leftstr(label4.caption,lcdccnt)=label5.caption then kaydir:=1;
if rightstr(label4.caption,lcdccnt)=label5.caption then kaydir:=-1;
shift := shift + kaydir;
end
else
label5.Caption:=label4.caption;

if length(label1.Caption)>lcdccnt then
begin
label6.Caption:=ansiMidStr(label1.caption,shift2,lcdccnt);
if leftstr(label1.caption,lcdccnt)=label6.caption then kaydir2:=1;
if rightstr(label1.caption,lcdccnt)=label6.caption then kaydir2:=-1;
shift2 := shift2 + kaydir2;
end
else
label6.Caption:=label1.caption;

// Burada ise programýmýz COMPort'a veri gönderecek.Verileri hazýrlýyoruz.

stra := chr(161) + label6.Caption + dupestring(' ',20-length(label6.Caption))  + chr(162) + label5.Caption + dupestring(' ',20-length(label5.Caption)) + chr(163) + label2.Caption + dupestring(' ',20-length(label2.Caption)) + chr(164) + label8.Caption + dupestring(' ',20-length(label8.Caption));

label7.Caption:=stra;

comport1.BaudRate := br9600;
comport1.DataBits := dbSeven;
comport1.Parity.Bits := prEven;
comport1.StopBits := sbTwoStopBits;

// Baðlantý oluþturuluyor.
try
comport1.connected:=true;
except
comport1.connected:=false;
end;

// Veriler Gidiyor

comport1.WriteStr(stra);

end;

procedure TForm1.OnClose(Sender: TObject; var Action: TCloseAction);
var strclose : string;
begin
strclose := chr(161) + dupestring(' ',20)  + chr(162) + dupestring(' ',20) + chr(163) + dupestring(' ',20) + chr(164) + dupestring(' ',20);
comport1.WriteStr(strclose);
if comport1.Connected=true then comport1.Close;
end;

procedure TForm1.rxchar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  ComPort1.ReadStr(Str, Count);
  edit1.Text:=ansileftstr(str,4);

end;

procedure TForm1.Edit1Change(Sender: TObject);
var str2 : string;
begin
str2:= edit1.text;
if ansileftstr(str2,4)='Play' then
  begin
  if wc1.IsPlaying then
  begin
  button3.click();
  end
  else
  begin
  button1.Click;
  end;
end;

  if ansileftstr(trim(str2),4)='Stop' then
  begin
  button2.Click();
  end;

  if ansileftstr(trim(str2),4)='Next' then
  begin
  button8.Click();
  end;

  if ansileftstr(trim(str2),4)='Prev' then
  begin
  button7.click();
  end;

  if ansileftstr(trim(str2),4)='Vol+' then
  begin
  button4.click();
  end;

  if ansileftstr(trim(str2),4)='Vol-' then
  begin
  button5.click();
  end;
  edit1.Text:='';
end;

procedure TForm1.comcombochange(Sender: TObject);
begin
comport1.Port:=comcombobox1.Items[comcombobox1.itemindex];
end;

end.
