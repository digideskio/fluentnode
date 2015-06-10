// Generated by CoffeeScript 1.8.0
(function() {
  var fs;

  require('./path');

  fs = require('fs');

  String.prototype.create_Parent_Folder = function() {
    this.valueOf().parent_Folder().folder_Create();
    return this;
  };

  String.prototype.folder_Create = function() {
    var target;
    target = this.valueOf();
    if (target.folder_Not_Exists()) {
      target.parent_Folder().folder_Create();
      fs.mkdirSync(target);
    }
    return target.realPath();
  };

  String.prototype.folder_Delete = function() {
    var folder;
    folder = this.toString();
    if (fs.existsSync(folder)) {
      fs.rmdirSync(folder);
    }
    return folder.not_Exists();
  };

  String.prototype.delete_Folder = String.prototype.folder_Delete;

  String.prototype.folder_Delete_Recursive = function() {
    var file, folder, subFolder, _i, _j, _len, _len1, _ref, _ref1;
    folder = this.toString();
    if (folder.exists()) {
      _ref = folder.files();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        file = _ref[_i];
        file.file_Delete();
      }
      _ref1 = folder.folders();
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        subFolder = _ref1[_j];
        subFolder.folder_Delete_Recursive();
      }
      folder.folder_Delete();
    }
    return folder.not_Exists();
  };

  String.prototype.file_Copy = function(target) {
    var content;
    if (!target) {
      return null;
    }
    if (this.valueOf().file_Not_Exists()) {
      return null;
    }
    if (target.folder_Exists()) {
      target = target.path_Combine(this.valueOf().file_Name());
    } else {
      target.parent_Folder().folder_Create();
    }
    content = fs.readFileSync(this.valueOf());
    fs.writeFileSync(target, content);
    return target;
  };

  String.prototype.file_Create = function() {
    var path;
    path = this.toString();
    if (path.not_Exists()) {
      fs.writeFileSync(path, '');
    }
    return path.realPath();
  };

  String.prototype.file_Delete = function() {
    var file;
    file = this.toString().realPath();
    if (!file) {
      return true;
    }
    fs.unlinkSync(file);
    return file.file_Not_Exists();
  };

  String.prototype.file_Contents = function() {
    var file;
    file = this.valueOf().realPath();
    try {
      return fs.readFileSync(file, "utf8");
    } catch (_error) {
      return null;
    }
  };

  String.prototype.file_Exists = function() {
    return fs.existsSync(this.valueOf());
  };

  String.prototype.exists = String.prototype.file_Exists;

  String.prototype.file_Lines = function() {
    var file_Contents;
    file_Contents = this.file_Contents();
    if (file_Contents !== null) {
      return file_Contents.lines();
    } else {
      return [];
    }
  };

  String.prototype.file_Write = function(content) {
    content.saveAs(this.str());
    return this;
  };

  String.prototype.file_Not_Exists = function() {
    return (fs.existsSync(this.valueOf())) === false;
  };

  String.prototype.files_And_Folders = function() {
    var item, path, _i, _len, _ref, _results;
    path = this.valueOf();
    try {
      _ref = fs.readdirSync(path);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(path.path_Combine(item).realPath());
      }
      return _results;
    } catch (_error) {
      return [];
    }
  };

  String.prototype.files = function(extension) {
    var file, files, item;
    files = (function() {
      var _i, _len, _ref, _results;
      _ref = this.files_And_Folders();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (item.is_File()) {
          _results.push(item);
        }
      }
      return _results;
    }).call(this);
    if (extension) {
      return (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = files.length; _i < _len; _i++) {
          file = files[_i];
          if (file.file_Extension() === extension) {
            _results.push(file);
          }
        }
        return _results;
      })();
    }
    return files;
  };

  String.prototype.files_Recursive = function(extension) {
    var files, item, _i, _len, _ref;
    files = [];
    _ref = this.str().files_And_Folders();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (item.is_Folder()) {
        files = files.concat(item.files_Recursive(extension));
      } else {
        if (!extension || item.file_Extension() === extension) {
          files.push(item);
        }
      }
    }
    return files;
  };

  String.prototype.folders = function() {
    var item, _i, _len, _ref, _results;
    _ref = this.files_And_Folders();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      if (item.is_Folder()) {
        _results.push(item);
      }
    }
    return _results;
  };

  String.prototype.is_Folder = function() {
    try {
      return fs.lstatSync(this.valueOf()).isDirectory();
    } catch (_error) {
      return false;
    }
  };

  String.prototype.is_Not_Folder = function() {
    return this.is_Folder() === false;
  };

  String.prototype.is_File = function() {
    try {
      return fs.lstatSync(this.valueOf()).isFile();
    } catch (_error) {
      return false;
    }
  };

  String.prototype.realPath = function() {
    try {
      return fs.realpathSync(this.valueOf());
    } catch (_error) {
      return null;
    }
  };

  String.prototype.temp_File = function(contents) {
    if (this.is_Folder()) {
      return this.temp_Name_In_Folder().file_Write(contents || '').valueOf();
    } else {
      return null;
    }
  };

  String.prototype.temp_Name_In_Folder = function() {
    return this.valueOf().realPath().path_Combine("_tmp_".add_Random_String(10));
  };

  String.prototype.save_As = function(targetFile) {
    var contents;
    if (targetFile === null || targetFile.length > 255) {
      return false;
    }
    contents = this.valueOf();
    if (targetFile.exists()) {
      targetFile.file_Delete();
    }
    fs.writeFileSync(targetFile, contents);
    if (targetFile.real_Path().exists()) {
      return targetFile.real_Path();
    }
  };

  String.prototype.saveAs = String.prototype.save_As;

  String.prototype.create_Dir = String.prototype.folder_Create;

  String.prototype.delete_File = String.prototype.file_Delete;

  String.prototype.folder_Exists = String.prototype.is_Folder;

  String.prototype.folder_Not_Exists = String.prototype.is_Not_Folder;

  String.prototype.fullPath = String.prototype.realPath;

  String.prototype.real_Path = String.prototype.realPath;

  String.prototype.is_Directory = String.prototype.is_Folder;

  String.prototype.touch = String.prototype.file_Create;

  String.prototype.not_Exists = String.prototype.file_Not_Exists;

}).call(this);