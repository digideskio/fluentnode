#back to [main](fluent.html)

require('../../src/fluentnode')

expect     = require('chai').expect

describe '| node-native | fs',->
  file_Contents = null
  tmp_File      = null
  tmp_Folder    = null

  beforeEach ->
    file_Contents = 'aaaa_'.add_5_Letters()
    tmp_Folder = '_temp_Folder_'.add_5_Letters().folder_Create()           .folder_Name()
    tmp_File   = '_temp_File_'  .add_5_Letters().file_Create(file_Contents).file_Name()

  afterEach ->
    tmp_File  .file_Delete()
    tmp_Folder.folder_Delete()

  it 'create_Parent_Folder', ->
    './aaa/abc.txt'.create_Parent_Folder().assert_Is './aaa/abc.txt'
    './aaa'.assert_Folder_Exists()
    "./aaa".delete_Folder().assert_True()

  it 'folder_Create and folder_Delete' , ->               # tests the String's folder_Create and folder_Delete methods
    ''.folder_Create.assert_Is_Function()                 # checks if String::folder_Create exists
    ''.folder_Delete.assert_Is_Function()                 # checks if String::folder_Delete exists
    tmpDir = "./".temp_Name_In_Folder()                   # get a temp folder name in the folder provided as string
    tmpDir.assert_Folder_Not_Exists()                     # asserts that folder doesn't exist
          .folder_Create().assert_Is tmpDir.realPath()    # creates folder and confirms that the return value is the full path to the folder
    tmpDir.assert_Folder_Exists()                         # assert that folders exists
          .folder_Delete().assert_Is_True()               # deletes folder (confirming OK result from delete action)
    tmpDir.assert_Folder_Not_Exists()                     # asserts that folder doesn't exist

    ''.folder_Delete.assert_Is ''.delete_Folder

  it 'folder_Create (and its parent)', ->
    tmpDir  = "./".temp_Name_In_Folder()
    tmpDir2 = tmpDir.path_Combine('aaa')
    tmpDir2.create_Dir().assert_That_Folder_Exists()
    tmpDir.folder_Delete_Recursive().assert_Is_True()

  it 'folder_Delete_Recursive' , ->
    tmpDir = "./"   .temp_Name_In_Folder().folder_Create()
    tmpFile = tmpDir.temp_Name_In_Folder().file_Create()
    tmpDir.folder_Delete_Recursive().assert_Is_True()
    tmpFile.assert_File_Not_Exists()

  it 'file_Append', (done)->
    original_Contents = tmp_File.file_Contents()
    extra_Contents_1    = "_bbbb".add_5_Letters()
    extra_Contents_2    = "_aaaa_".add_5_Letters()

    tmp_File.file_Append extra_Contents_1
    tmp_File.file_Contents().assert_Is original_Contents + extra_Contents_1
    tmp_File.file_Append extra_Contents_2, (fileName)->
      fileName.assert_Is tmp_File.real_Path()
      tmp_File.file_Contents().assert_Is original_Contents + extra_Contents_1 + extra_Contents_2
      done()



  it 'file_Create and file_Delete',->
    tmpName = '.'.temp_Name_In_Folder()
    tmpName.file_Create().assert_Is(tmpName)
    tmpName.exists()     .assert_True()
    tmpName.file_Delete().assert_True()
    tmpName.exists()     .assert_False()

    tmpName.file_Create('abc123')
    tmpName.assert_File_Contents('abc123')
    tmpName.assert_File_Deleted()

  it 'file_Copy' , ->
    file1 = '.'.temp_Name_In_Folder()
    file2 = '.'.temp_Name_In_Folder()
    file1.file_Create().assert_Is(file1)
    file1.assert_File_Exists()
    file1.file_Copy(file2)
    file2.assert_File_Exists()

    folder         = '_tmp_file_Copy'.folder_Create()
    file_In_Folder = file1.file_Copy(folder)
    file_In_Folder.assert_File_Exists()

    assert_Is_Null('aaa'.file_Copy('bbb'))
    assert_Is_Null(file1.file_Copy(null))

    folder.folder_Delete_Recursive().assert_True()
    file1.file_Delete().assert_True()
    file2.file_Delete().assert_True()

  it 'file_Contents' , ->
    ''.file_Contents.assert_Is_Function()
    file_Name     = '_temp_name_'.add_Random_String(5)
    file_Contents = 'value_'.add_Random_String(5)
    (file_Name.file_Exists().assert_Is_False())
    file_Contents.save_As(file_Name)
    file_Name.file_Exists().assert_Is_True()
    file_Name.file_Contents().assert_Is(file_Contents)
    file_Name.file_Delete().assert_Is_True()

  it 'file_Delete', ->
    # see other tests on 'file_Create and file_Delete'
    'aaaaa'.file_Delete().assert_Is_True()

  it 'file_Exists' , ->
    ''.file_Exists.assert_Is_Function()
    tmp_Folder  .file_Exists().assert_Is_True()
    tmp_File    .file_Exists().assert_Is_True()
    './aaa.js'  .file_Exists().assert_Is_False()
    './aaa.js'  .file_Exists().assert_Is_False()

  it 'file_Lines', ->
    "".file_Lines().assert_Is []
    tmp_File_2 = "aaaa\nbbbb".save_As('_tmp_file_Lines')
    tmp_File_2.file_Lines().assert_Is ['aaaa','bbbb']
    tmp_File_2.assert_File_Deleted()

  it 'file_Not_Exists' , ->
    ''.file_Not_Exists.assert_Is_Function()
    tmp_Folder  .file_Not_Exists().assert_Is_False()
    './index.js'.file_Not_Exists().assert_Is_True()
    './aaa.js'  .file_Not_Exists().assert_Is_True()

  it 'file_Write',->
    content = (20).random_Letters()
    tmpFile = './src'.fullPath().path_Combine('_temp_file.abcd').assert_File_Not_Exists()
                                .file_Write(content)
    tmpFile.assert_File_Exists()
           .file_Contents().assert_Is(content)
    tmpFile.file_Delete().assert_Is_True()

  it 'files_And_Folders',->
    ''.files_And_Folders.assert_Is_Function()
    files = './'.files_And_Folders();
    files.assert_Contains tmp_File    .realPath()
         .assert_Contains tmp_Folder  .realPath()
         .assert_Not_Contains '.aaaaa'.realPath()

    'aaaa'.files_And_Folders().assert_Is([])

  it 'files' , ->
    ''.files.assert_Is_Function()
    tmp_File_2   = '_temp_File_'  .add_5_Letters().append('.txt').file_Create(file_Contents).file_Name()
    files = './'.files()
    expectedFiles = [tmp_File.real_Path(), tmp_File_2.real_Path()]

    files.assert_Contains(expectedFiles)

    files = './'.files('.txt')
    files.assert_Contains(tmp_File_2.real_Path())

    tmp_File_2.assert_File_Deleted()

  it 'files_Recursive' , ->
    extension = __filename.file_Extension().replace('coffee', 'litcoffee')
    file_To_Find = "./src/node-native/fs#{extension}".fullPath()

    ''.files_Recursive.assert_Is_Function()
    './src'.files_Recursive().assert_Size_Is_Bigger_Than(9)
                             .assert_Contains(file_To_Find)
    tmpFile = './src'.fullPath().path_Combine('_temp_file.abcd').file_Write((20).random_Letters())
    './src'.files_Recursive('.abcd').assert_Size_Is(1)
                                    .first().assert_Is(tmpFile)
    tmpFile.file_Delete().assert_Is_True()

  it 'folder_Names', ->
    '.'.folders().folder_Names().assert_Contains tmp_Folder.folder_Name()

  it 'folders' , ->
    ''.folders.assert_Is_Function()
    folders = '.'.folders()
    expectedFolders = (folder.realPath() for folder in 'src,test'.split(','))
    folders.assert_Contains(expectedFolders)

  it 'folders_Recursive' , ->
    root_Folder = wallaby?.localProjectDir || '.'
    target_Folder = root_Folder.path_Combine 'docs'
    target_Folder.folders_Recursive().folder_Names().assert_Is [ 'fonts', 'images', 'stylesheets', 'public' ]

  it 'is_Folder', ->
    ''          .is_Folder  .assert_Is_Function()
    tmp_Folder  .is_Folder().assert_Is_True()
    tmp_File    .is_Folder().assert_Is_False()
    '.gitAAA'   .is_Folder().assert_Is_False()

  it 'is_Not_Folder',->
    "".add_5_Random_Letters().is_Not_Folder().assert_Is_True()

  it 'is_File', ->
    ''.is_File .assert_Is_Function()
    tmp_Folder .is_File().assert_Is_False()
    tmp_File   .is_File().assert_Is_True()
    '.gitAAA'  .is_File().assert_Is_False()

  it 'realPath', ->
    tmp_Folder.realPath().assert_Is process.cwd().path_Combine tmp_Folder
    tmp_File  .realPath().assert_Is process.cwd().path_Combine tmp_File
    assert_Is_Null '.gitignore2' .realPath()

  it 'save_As', ->
    file_Name  = '_tmp_file_'.add_Random_String(5)
    file_Value1 = 'value'    .add_Random_String(5)
    file_Value2 = 'value'    .add_Random_String(5)

    file_Name.exists().assert_Is_False()

    file_Value1.save_As(file_Name).assert_Is(file_Name.real_Path()).assert_File_Exists()
    file_Name.exists()            .assert_Is_True()
    file_Name.file_Contents()     .assert_Is    (file_Value1)
    file_Name.file_Contents()     .assert_Is_Not(file_Value2)

    file_Value2.save_As(file_Name).assert_Is(file_Name.real_Path()).assert_File_Exists()
    file_Name.exists()            .assert_Is_True()
    file_Name.file_Contents()     .assert_Is_Not(file_Value1)
    file_Name.file_Contents()     .assert_Is    (file_Value2)

    file_Name.file_Delete()       .assert_Is_True()

    ''.save_As.assert_Is ''.saveAs


  it 'Save_As file path must be 255 characters max', ->
    file_Name    = '_tmp_file_'.add_Random_String(245)
    file_Content = ''.add_Random_String(100);
    file_Name.length.assert_Is(255);
    file_Content.save_As(file_Name)           # save_As returns full path to file created
                .assert_File_Exists()         # confirms it exists
                .assert_File_Deleted()        # deletes file and confirms deletion

  it 'Save_As file path must be 255 characters max (file must not be created)', ->
    file_Name    = '_tmp_file_'.add_Random_String(1000)
    file_Content = ''.add_Random_String(100);
    file_Name.length                .assert_Is(1010);
    file_Content                    .save_As(file_Name)
                                    .assert_Is_False()

    file_Name.exists()              .assert_Is_False()

  it 'temp_File',->
    value = "abc".add_5_Letters()
    './'.temp_File(value).assert_File_Exists()
                         .assert_File_Contents(value)
                         .assert_File_Deleted()
    './'.temp_File(null ).assert_File_Exists()
                         .assert_File_Contents('')
                         .assert_File_Deleted()

    assert_Is_Null 'aaaaaa'.temp_File()

  it 'temp_Name_In_Folder', ->
    tmpName = './'.temp_Name_In_Folder()
    expect(tmpName       ).to.contain('./'.realPath())
    expect(tmpName       ).to.contain('_tmp_')
    expect(tmpName.size()).to.equal('./'.realPath().size()+16)

  it 'touch',->
    expect(''.touch).to.be.an('function')
    tempFile = '.'.temp_Name_In_Folder().touch()
    expect(tempFile.file_Exists()).to.be.true
    expect(tempFile.file_Delete()).to.be.true

  it 'exists'       , -> expect('.git'.exists       ).to.equal(".git".file_Exists)
  it 'create_Dir'   , -> expect('.git'.create_Dir   ).to.equal(".git".folder_Create)
  it 'folder_Exists', -> expect('.git'.folder_Exists).to.equal(".git".is_Folder)
  it 'is_Directory' , -> expect('.git'.is_Directory ).to.equal(".git".is_Folder)
