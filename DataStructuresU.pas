unit DataStructuresU;

interface

type
  TProjectData = class(TObject)
                 public
                   ID,
                   Caption,
                   FileName :String;
                   constructor Create();
                 end;

implementation

{ TProjectData }

constructor TProjectData.Create;
begin
ID := '';
Caption := '(object)';
FileName := '';
end;

end.


