require 'fox16'
require 'sqlite3'
include Fox

class Window < FXMainWindow
  def initialize(app)

    db = SQLite3::Database.open 'PC_firm.db'

    super(app, "Main window" , :width => 700, :height => 350)

    # Menubar
    menubar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X)

    # Separator
    FXHorizontalSeparator.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X|SEPARATOR_GROOVE)

    contents = FXVerticalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    frame = FXVerticalFrame.new(contents,
      FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y, :padding => 0)

    # Table
    @table = FXTable.new(frame,
      :opts => TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE|LAYOUT_FILL_X|LAYOUT_FILL_Y,
      :padding => 2)

    @table.visibleRows = 15
    @table.visibleColumns = 6

    @table.setTableSize(15, 6)

    # Initialize the scrollable part of the table
    i = 0
    db.execute("select * from posts") do |row|
        @table.setItemText(i, 0, row[1])
        @table.setItemText(i, 1, row[2].to_s)
        i += 1
    end

    # Initialize column headers
    # (0...6).each  { |c| @table.setColumnText(c, Date::MONTHNAMES[c+1]) }

    # Initialize row headers
    (0...15).each { |r| @table.setRowText(r, r.to_s) }

    # Manipulations Menu
    manipmenu = FXMenuPane.new(self)
    FXMenuCommand.new(manipmenu, "Удалить запись").connect(SEL_COMMAND, method(:delete_note))
    FXMenuCommand.new(manipmenu, "Добавить запись").connect(SEL_COMMAND, method(:insert_note))
    FXMenuCommand.new(manipmenu, "Изменить запись").connect(SEL_COMMAND, method(:change_note))
    FXMenuTitle.new(menubar, "Операции с таблицей", nil, manipmenu)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def insert_note(sender, sel, ptr)
    # Create an empty dialog box
    form = FXDialogBox.new(self, "Добавить запись")

    # Set up its contents
    frame = FXHorizontalFrame.new(form, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Должность", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    post_field = FXTextField.new(frame, 20,
      :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Зарплата", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    salary_field = FXTextField.new(frame, 20,
      :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Cancel", nil, form, FXDialogBox::ID_CANCEL,
      FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "  OK  ", nil, form, FXDialogBox::ID_ACCEPT,
      FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    # FXDialogBox#execute will return non-zero if the user clicks OK
    if form.execute != 0 then
      post, salary = post_field.text, salary_field.text.to_i

      db = SQLite3::Database.open 'PC_firm.db'
      db.execute("INSERT INTO posts(post_name, salary)
      VALUES ('#{post}', #{salary})")
    end
    return 1
  end

  def change_note(sender, sel, ptr)
    # Create an empty dialog box
    form = FXDialogBox.new(self, "Изменить запись")

    # Set up its contents
    frame = FXHorizontalFrame.new(form, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Должность", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    post_field = FXTextField.new(frame, 20,
      :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Зарплата", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    salary_field = FXTextField.new(frame, 20,
      :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Cancel", nil, form, FXDialogBox::ID_CANCEL,
      FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "  OK  ", nil, form, FXDialogBox::ID_ACCEPT,
      FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    post_field.text = @table.getItemText(@table.currentRow, @table.currentColumn)
    salary_field.text = @table.getItemText(@table.currentRow, @table.currentColumn+1)

    # FXDialogBox#execute will return non-zero if the user clicks OK
    if form.execute != 0 then
      db = SQLite3::Database.open 'PC_firm.db'
      db.execute("UPDATE posts SET salary = #{salary_field}
      WHERE post_name == '#{@table.getItemText(@table.currentRow, @table.currentColumn)}'")
    end
    return 1
  end

  def delete_note(sender, sel, ptr)
    # Create an empty dialog box
    form = FXDialogBox.new(self, "Удалить запись")

    # Set up its contents
    frame = FXHorizontalFrame.new(form, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Удалить выбранную запись?", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    FXButton.new(frame, "Cancel", nil, form, FXDialogBox::ID_CANCEL,
      FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "  OK  ", nil, form, FXDialogBox::ID_ACCEPT,
      FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    # FXDialogBox#execute will return non-zero if the user clicks OK
    if form.execute != 0 then
      db = SQLite3::Database.open 'PC_firm.db'
      db.execute("DELETE FROM posts WHERE post_name == '#{@table.getItemText(@table.currentRow, @table.currentColumn)}'")
      @table.removeRows(@table.currentRow)
    end
    return 1
  end

end

app = FXApp.new
Window.new(app)
app.create
app.run
