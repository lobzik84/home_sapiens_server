var fls = [];
var fkeys = [];
var uids = [];
var uploaded = [];
var fileIndex = 0;

function clearFileArrays() {
    fls = [];
    fkeys = [];
    uids = [];
    uploaded = [];
    fileIndex = 0;
}

function getExtension(fname) {
    var ext = fname.toLowerCase();
    var ind = fname.lastIndexOf(".");
    if (ind > 0) {
        ext = ext.substr(ind + 1);
    }
    return ext;
}
function getContentTypeClass(fname) {

    var ext = getExtension(fname)
    var cl = '';
   
    switch (ext) {
        case 'txt': cl='txt';break;
        case 'doc': cl='doc';break;
        case 'docx': cl='doc';break;
        case 'odt': cl='doc';break;
        case 'rtf': cl='doc';break;
        case 'ppt': cl='ppt';break;
        case 'pdf': cl='pdf';break;
        case 'djvu': cl='djvu';break;
        case 'exe': cl='exe';break;
        case 'jpg': cl='image';break;
        case 'png': cl='image';break;
        case 'gif': cl='image';break;
        case 'bmp': cl='image';break;
        case 'jpeg': cl='image';break;
        default:  cl='';   
    }

    return cl;
}
function humanBytes(length) {
    var units = ['B', 'KB', 'MB', 'GB'];
    var step = 1024;
    var number = length;
    for (i = 0; i < units.length; i++) {
        var unit = units[i];
        if (number < step) {
            var numStr;
            if (number < 2)
                numStr = number.toFixed(2);
            else
                numStr = number.toFixed(1);
            if (i == 0)
                numStr = number.toFixed(0);
            return (numStr + ' ' + unit);
        }

        number = number / step;
    }
    return (length + ' ' + units[0]);
}

function generateUid() {
    var uid_alphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var uid = "";
    var uid_length = 16;
    for (i = 0; i < uid_length; i++) {
        var ch = uid_alphabet.charAt(Math.floor(Math.random() * uid_alphabet.length));
        uid += ch;
    }
    return uid;
}

function handleFileSelectDoc(evt) {
    var files = evt.target.files; 
    for (var i = 0, f; f = files[i]; i++) {
        if (f.size > maxFileSize) {
            alert("Selected file size " + f.name + " - " + humanBytes(f.size) + " is over the system's limit  (" + humanBytes(maxFileSize) + "). File will not be uploaded.\n");
            continue;
        }
        var uid = generateUid();
        var rng = new SecureRandom();
        var key = (new BigInteger(256, 1, rng)).toString(16);
        fkeys.push(key);
        fls.push(f);
        uids.push(uid);
        addToDocList(f, uid, key);
        
    }
    uploadNextFile();
}

function handleFileSelectDoc2(evt) {
    var files = evt.target.files; 
    for (var i = 0, f; f = files[i]; i++) {
        if (f.size > maxFileSize) {
            alert("Selected file size " + f.name + " - " + humanBytes(f.size) + " is over the system's limit  (" + humanBytes(maxFileSize) + "). File will not be uploaded.\n");
            continue;
        }
        var uid = generateUid();
        var rng = new SecureRandom();
        var key = (new BigInteger(256, 1, rng)).toString(16);
        fkeys.push(key);
        fls.push(f);
        uids.push(uid);
        addToDocList2();
        
    }
    uploadNextFile();
};

var submit_post_btn = null;

function handleFileSelect(evt) {
    var files = evt.target.files; 
    var hash = evt.target.hash; // FileList object
		if(hash == null){
			hash = '';
		}
        
        submit_post_btn = document.getElementById('submit_post_btn' + hash);
        $(submit_post_btn).addClass('disabled').append('<span title="Encrypt & Post (Ctrl+Enter)" class="btn">Encrypt & Post</span>');
    for (var i = 0, f; f = files[i]; i++) {
        if (f.size > maxFileSize) {
            alert("Selected file size " + f.name + " - " + humanBytes(f.size) + " is over the system's limit  (" + humanBytes(maxFileSize) + "). File will not be uploaded.\n");
            continue;
        }
        var uid = generateUid();
        var rng = new SecureRandom();
        var key = (new BigInteger(256, 1, rng)).toString(16);
        fkeys.push(key);
        fls.push(f);
        uids.push(uid);
    }
    addToUploadList(uid, hash);
    uploadNextFile();
}

function addToUploadList(uid, hash) {
  var html =[];
   //var k = fls.length-1;
   for (var k = 0, len = fls.length; k < len; k++){
        html.push("<li id=\"", uids[k], "_li\">");
        html.push("<a class=\"file-icon ", getContentTypeClass(fls[k].name),"\"");
        html.push(" href=# onclick=\"downloadFile(\'", uids[k], "\',\'", fls[k].name, "\',\'", fkeys[k], "\',", fls[k].size, ")\">");
        html.push(fls[k].name);
        html.push("</a> - ", humanBytes(fls[k].size));
        html.push("&nbsp; <span class=\"percents\" id=\'" + uids[k] + "_prog\'></span>");
        html.push("<a class=\"file-delete\" onclick=\"deleteUploadedFile(\'",uids[k],"\',\'",hash,"\')\" href=\"#\">del</a>")
        html.push("</li>");
    }
    if(document.getElementById("filesUploaded"+hash) === null) {
      document.getElementById('uploadedList' + hash).innerHTML = '<small>Files Attached:</small> <ul id="filesUploaded'+hash+'" class="filesUploaded">' + html.join('') + "</ul>";
    } else {
      document.getElementById("filesUploaded"+hash).innerHTML = document.getElementById("filesUploaded"+hash).innerHTML + html.join('');
    }
    document.getElementById('filesAttached' + hash).value = document.getElementById('filesAttached' + hash).value + uid + ",";
}

function addToDocList(f, uid, key) {
    var date = new Date();
    var author = ''; if (document.getElementById('username') != null ) author = document.getElementById('username').innerHTML;
    //var formatted = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " +  date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
    var formatted = date.getFullYear() + "." + (date.getMonth() + 1) + "." + date.getDate();
    var html =[];
    for (var k = 0; k < fls.length; k++) {
        html.push("<li id=\"", uids[k], "_li\">");
        html.push("<a class=\"file-icon ", getContentTypeClass(fls[k].name),"\"");
        html.push(" href=# onclick=\"downloadFile(\'", uids[k], "\',\'", fls[k].name, "\',\'", fkeys[k], "\',", fls[k].size, ")\">");
        html.push(fls[k].name, "</a>");
        html.push("<p class=\"secondary-date\">");
        html.push(" <span class=\"date\">", "Date: ", formatted, "</span>");
        html.push(" <span class=\"author\">", "Author: ",author,"</span>");
        html.push(" <span class=\"size\">", humanBytes(fls[k].size),"</span>");
        html.push(" <span class=\"percents\" id=\'" + uids[k] + "_prog\'></span>");
        html.push("<span class=\"encrypts cmtstatus\"><span class=\"encrypt-success\" title=\"Encrypted\"></span></span>");
        html.push("<span class=\"encrypts cmtepstatus\"><span class=\"encrypt-success\" title=\"Encrypted\"></span></span>");        
        html.push("<span class=\"file-delete\" onclick=\"if(confirm(\'Do you want to delete a file?\')) {deleteUploadedFile(\'",uids[k],"\')}\" >del</span>");
        html.push("</p></li>");
    }

    document.getElementById('documentList').innerHTML = document.getElementById('documentServerList').innerHTML + html.join('');
    document.getElementById('filesAttached').value = document.getElementById('filesAttached').value + uid + ",";
}

function addToDocList2() {
    var date = new Date();
    var author = ''; if (document.getElementById('username') != null ) author = document.getElementById('username').innerHTML;
    var formatted = date.getFullYear() + "." + (date.getMonth() + 1) + "." + date.getDate();
    var html =[];
    var k = fls.length-1;
    {
        html.push("<li id=\"", uids[k], "_li\">");
        html.push("<a class=\"sn-document ", getExtension(fls[k].name),"\"");
        html.push(" href=# onclick=\"downloadFile(\'", uids[k], "\',\'", fls[k].name, "\',\'", fkeys[k], "\',", fls[k].size, ")\">");
        html.push(fls[k].name, "</a>");
        html.push("<div style=\"display:none;\">");
        html.push("<span id=\"nfa_name_",uids[k],"\">",fls[k].name,"</span>");
        html.push("<span id=\"nfa_ext_",uids[k],"\">",getExtension(fls[k].name),"</span>");
        html.push("<span id=\"nfa_size_",uids[k],"\">",fls[k].size,"</span>");
        html.push("<span id=\"nfa_uid_",uids[k],"\">",uids[k],"</span>");
        html.push("<span id=\"nfa_key_",uids[k],"\">",fkeys[k],"</span>", "</div>");
        html.push("<p class=\"secondary-date\">");
        html.push(" <span class=\"date\">", "Date: ", formatted, "</span>");
        html.push(" <span class=\"author\">", "Author: ",author,"</span>");
        html.push(" <span class=\"size\">", humanBytes(fls[k].size),"</span>");
        html.push(" <span class=\"percents\" id=\'" + uids[k] + "_prog\'></span>");
        html.push("<a class=\"file-delete\" onclick=\"if(confirm(\'Do you want to delete a file?\')) {deleteUploadedFile(\'",uids[k],"\')}\" >del</span>");
        html.push("</p></li>");
    }
    document.getElementById('documents-list').innerHTML = document.getElementById('documents-list').innerHTML + html.join('');
}


function deleteUploadedFile(uid, hash) {
    if(hash == null){
        hash = '';
    }
    var element = document.getElementById(uid+'_li');
    if (element != null) element.parentNode.removeChild(element);
    var index = uids.indexOf(uid);
    if (index > -1) {
        uids.splice(index, 1);
        fkeys.splice(index, 1);
        fls.splice(index, 1);
    }
    //TODO ваще-то надо и из БД подтирать, и с сервера
    element = document.getElementById('filesAttached' + hash);
    if (element != null) {
        element.value = element.value.replace(uid, '');
    }
    if(fls.length === 0) {
      $(submit_post_btn).removeClass('disabled').find('span.btn').remove();
    }
}

function uploadFiles() {
    if (fls.length === 0)
        return;
    uploadNextFile();
}

function uploadNextFile() {
    if (fileIndex >= fls.length){
      console.log(fileIndex);
      clearFileArrays();
      $(submit_post_btn).removeClass('disabled').find('span.btn').remove();
      return;
    }
    var file = fls[fileIndex];
    var uid = uids[fileIndex];
    var key = fkeys[fileIndex];
    fileIndex++;
    var aeskey = new Uint8Array(cryptoHelpers.toNumbers(key));
    before = new Date();
    readNextChunk(uid, file, 0, aeskey);
}

function readNextChunk(uid, file, offset, aeskey) {
    var end = offset + chunkSize;
    if (end > file.size)
        end = file.size;
    var blob = file.slice(offset, end);
    var reader = new FileReader();
    reader.readAsArrayBuffer(blob);
    reader.onloadend = function(evt) {
        if (evt.target.readyState == FileReader.DONE) { // DONE == 2
            var chunk = evt.target.result;
            var bytes = new Uint8Array(chunk);
            var cipherBytes;
            if (aeskey != undefined && aeskey.length == 32)
                //cipherBytes = slowAES.encrypt(Array.apply([], bytes), mode, aeskey, aeskey);
                //cipherBytes = slowAES.encrypt(bytes, mode, aeskey, aeskey);
                cipherBytes = asmCrypto.AES_CFB.encrypt(bytes, aeskey, end === file.size);
            else
                cipherBytes = bytes;
            console.log(cipherBytes.length);
            uploadChunk(uid, file, offset, cipherBytes, aeskey);
        }
    }
}



function uploadChunk(uid, file, offset, cont, aeskey) {
    var speed = humanBytes(offset * 1000 / (new Date() - before)) + "/sec";
    document.getElementById(uid + '_prog').innerHTML = '<nobr style="width:'+Math.ceil(100 * offset / file.size)+'%;">' + Math.ceil(100 * offset / file.size) + "% uploaded, " + speed + '</nobr>';
    xhr = new XMLHttpRequest();
    var target = fileUploadBaseUrl + uid + "?f=" + offset;
    xhr.open('POST', target, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                var newoffset = offset + chunkSize;
                if (newoffset >= file.size) {

                    finalizeFile(file, uid, aeskey);
                    return; //done
                }
                readNextChunk(uid, file, newoffset, aeskey);
            } else {
                alert("Upload failed! \n Error " + xhr.status + ": " + xhr.responseText);
            }
        }
    }
    xhr.send(cont);
}

function finalizeFile(file, uid, aeskey) {
    xhr = new XMLHttpRequest();
    var target = fileUploadBaseUrl + uid + "?done=true";
    xhr.open('POST', target, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                var speed = humanBytes(file.size * 1000 / (new Date() - before)) + "/sec";
                document.getElementById(uid + '_prog').innerHTML = "";
                addClass(document.getElementById(uid + '_prog'), "complete");
                //
                ////upload done, " + speed;
                //addToUploadedList(file, uid, aeskey);
//                if (document.getElementById('submit_post_btn') !== null) document.getElementById('submit_post_btn').style.display = 'block';
                uploadNextFile();
            }
        }
    }
    xhr.send();
    var e = $(document).cascade().createEventX("olololo");
    var commands = ["DocumentAdd"];
    if (document.getElementById('sn_doc_file') != null) remote(e, commands); //TODO лучшего способа определить, что мы именно в документах, яне придумал
}

function downloadDocument(uid, name, keycipher, size, groupId, updated) {
    var filekey = keycipher;
    if (groupId > 0) {
        var groupKey = kf.getGroupKey(groupId, updated);
        var keyBytes = cryptoHelpers.toNumbers(keycipher);
        var key = slowAES.decrypt(keyBytes, mode, groupKey, groupKey);
        filekey = cryptoHelpers.toHex(key);
    }
        
    downloadFile(uid, name, filekey, size);
}

function downloadFile(uid, name, key, size) {
    var data = [];
    var aeskey = new Uint8Array(cryptoHelpers.toNumbers(key));
    before = new Date();
    downloadChunk(uid, name, 0, data, aeskey, size);
}

function downloadChunk(uid, name, offset, data, aeskey, size) {
    xhr = new XMLHttpRequest();
    var target = fileDownloadBaseUrl + uid + "?f=" + offset + "&c=" + chunkSize;
    var speed = humanBytes(offset * 1000 / (new Date() - before)) + "/sec";
    document.getElementById(uid + '_prog').innerHTML = Math.ceil(100 * offset / size) + "% downloaded, " + speed;
    xhr.open('GET', target, true);
    xhr.responseType = "arraybuffer";
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                if (xhr.response == null)
                    saveFile(name, data);
                else {
                    var bytes = new Uint8Array(xhr.response);
                    decryptChunk(uid, name, bytes, offset, data, aeskey, size);
                }
            } else {
                alert("Download failed! \n Error " + xhr.status + ": " + xhr.responseText);
            }
        }
    }
    xhr.send();
}

function decryptChunk(uid, name, bytes, offset, data, aeskey, size) {
    var decrypted;

    if (aeskey != undefined && aeskey.length == 32)
        decrypted = asmCrypto.AES_CFB.decrypt(bytes, aeskey, bytes.length < chunkSize);
    else
        decrypted = bytes;
    data.push(decrypted);

    if (bytes.length == chunkSize) {
        var newoffset = offset + chunkSize;
        downloadChunk(uid, name, newoffset, data, aeskey, size);
    } else {
        var speed = humanBytes(size * 1000 / (new Date() - before)) + "/sec";
        document.getElementById(uid + '_prog').innerHTML = "saving file, " + speed;
        saveFile(name, data);
    }
}
function saveFile(name, data) {

    var blob = new Blob(data, {type : 'application/octet-stream'});
    saveAs(blob, name);
}


var saveAs = saveAs
        // IE 10+ (native saveAs)
        || (typeof navigator !== "undefined" &&
                navigator.msSaveOrOpenBlob && navigator.msSaveOrOpenBlob.bind(navigator))
        // Everyone else
        || (function(view) {
            "use strict";
            // IE <10 is explicitly unsupported
            if (typeof navigator !== "undefined" &&
                    /MSIE [1-9]\./.test(navigator.userAgent)) {
                return;
            }
            var
                    doc = view.document
                    // only get URL when necessary in case Blob.js hasn't overridden it yet
                    , get_URL = function() {
                        return view.URL || view.webkitURL || view;
                    }
            , save_link = doc.createElementNS("http://www.w3.org/1999/xhtml", "a")
                    , can_use_save_link = !view.externalHost && "download" in save_link
                    , click = function(node) {
                        var event = doc.createEvent("MouseEvents");
                        event.initMouseEvent(
                                "click", true, false, view, 0, 0, 0, 0, 0
                                , false, false, false, false, 0, null
                                );
                        node.dispatchEvent(event);
                    }
            , webkit_req_fs = view.webkitRequestFileSystem
                    , req_fs = view.requestFileSystem || webkit_req_fs || view.mozRequestFileSystem
                    , throw_outside = function(ex) {
                        (view.setImmediate || view.setTimeout)(function() {
                            throw ex;
                        }, 0);
                    }
            , force_saveable_type = "application/octet-stream"
                    , fs_min_size = 0
                    // See https://code.google.com/p/chromium/issues/detail?id=375297#c7 for
                    // the reasoning behind the timeout and revocation flow
                    , arbitrary_revoke_timeout = 10
                    , revoke = function(file) {
                        setTimeout(function() {
                            if (typeof file === "string") { // file is an object URL
                                get_URL().revokeObjectURL(file);
                            } else { // file is a File
                                file.remove();
                            }
                        }, arbitrary_revoke_timeout);
                    }
            , dispatch = function(filesaver, event_types, event) {
                event_types = [].concat(event_types);
                var i = event_types.length;
                while (i--) {
                    var listener = filesaver["on" + event_types[i]];
                    if (typeof listener === "function") {
                        try {
                            listener.call(filesaver, event || filesaver);
                        } catch (ex) {
                            throw_outside(ex);
                        }
                    }
                }
            }
            , FileSaver = function(blob, name) {
                // First try a.download, then web filesystem, then object URLs
                var
                        filesaver = this
                        , type = blob.type
                        , blob_changed = false
                        , object_url
                        , target_view
                        , dispatch_all = function() {
                            dispatch(filesaver, "writestart progress write writeend".split(" "));
                        }
                // on any filesys errors revert to saving with object URLs
                , fs_error = function() {
                    // don't create more object URLs than needed
                    if (blob_changed || !object_url) {
                        object_url = get_URL().createObjectURL(blob);
                    }
                    if (target_view) {
                        target_view.location.href = object_url;
                    } else {
                        var new_tab = view.open(object_url, "_blank");
                        if (new_tab == undefined && typeof safari !== "undefined") {
                            //Apple do not allow window.open, see http://bit.ly/1kZffRI
                            view.location.href = object_url
                        }
                    }
                    filesaver.readyState = filesaver.DONE;
                    dispatch_all();
                    revoke(object_url);
                }
                , abortable = function(func) {
                    return function() {
                        if (filesaver.readyState !== filesaver.DONE) {
                            return func.apply(this, arguments);
                        }
                    };
                }
                , create_if_not_found = {create: true, exclusive: false}
                , slice
                        ;
                filesaver.readyState = filesaver.INIT;
                if (!name) {
                    name = "download";
                }
                if (can_use_save_link) {
                    object_url = get_URL().createObjectURL(blob);
                    save_link.href = object_url;
                    save_link.download = name;
                    click(save_link);
                    filesaver.readyState = filesaver.DONE;
                    dispatch_all();
                    revoke(object_url);
                    return;
                }
                // Object and web filesystem URLs have a problem saving in Google Chrome when
                // viewed in a tab, so I force save with application/octet-stream
                // http://code.google.com/p/chromium/issues/detail?id=91158
                // Update: Google errantly closed 91158, I submitted it again:
                // https://code.google.com/p/chromium/issues/detail?id=389642
                if (view.chrome && type && type !== force_saveable_type) {
                    slice = blob.slice || blob.webkitSlice;
                    blob = slice.call(blob, 0, blob.size, force_saveable_type);
                    blob_changed = true;
                }
                // Since I can't be sure that the guessed media type will trigger a download
                // in WebKit, I append .download to the filename.
                // https://bugs.webkit.org/show_bug.cgi?id=65440
                if (webkit_req_fs && name !== "download") {
                    name += ".download";
                }
                if (type === force_saveable_type || webkit_req_fs) {
                    target_view = view;
                }
                if (!req_fs) {
                    fs_error();
                    return;
                }
                fs_min_size += blob.size;
                req_fs(view.TEMPORARY, fs_min_size, abortable(function(fs) {
                    fs.root.getDirectory("saved", create_if_not_found, abortable(function(dir) {
                        var save = function() {
                            dir.getFile(name, create_if_not_found, abortable(function(file) {
                                file.createWriter(abortable(function(writer) {
                                    writer.onwriteend = function(event) {
                                        target_view.location.href = file.toURL();
                                        filesaver.readyState = filesaver.DONE;
                                        dispatch(filesaver, "writeend", event);
                                        revoke(file);
                                    };
                                    writer.onerror = function() {
                                        var error = writer.error;
                                        if (error.code !== error.ABORT_ERR) {
                                            fs_error();
                                        }
                                    };
                                    "writestart progress write abort".split(" ").forEach(function(event) {
                                        writer["on" + event] = filesaver["on" + event];
                                    });
                                    writer.write(blob);
                                    filesaver.abort = function() {
                                        writer.abort();
                                        filesaver.readyState = filesaver.DONE;
                                    };
                                    filesaver.readyState = filesaver.WRITING;
                                }), fs_error);
                            }), fs_error);
                        };
                        dir.getFile(name, {create: false}, abortable(function(file) {
                            // delete file if it already exists
                            file.remove();
                            save();
                        }), abortable(function(ex) {
                            if (ex.code === ex.NOT_FOUND_ERR) {
                                save();
                            } else {
                                fs_error();
                            }
                        }));
                    }), fs_error);
                }), fs_error);
            }
            , FS_proto = FileSaver.prototype
                    , saveAs = function(blob, name) {
                        return new FileSaver(blob, name);
                    }
            ;
            FS_proto.abort = function() {
                var filesaver = this;
                filesaver.readyState = filesaver.DONE;
                dispatch(filesaver, "abort");
            };
            FS_proto.readyState = FS_proto.INIT = 0;
            FS_proto.WRITING = 1;
            FS_proto.DONE = 2;

            FS_proto.error =
                    FS_proto.onwritestart =
                    FS_proto.onprogress =
                    FS_proto.onwrite =
                    FS_proto.onabort =
                    FS_proto.onerror =
                    FS_proto.onwriteend =
                    null;

            return saveAs;
        }(
                typeof self !== "undefined" && self
                || typeof window !== "undefined" && window
                || this.content
                ));
// `self` is undefined in Firefox for Android content script context
// while `this` is nsIContentFrameMessageManager
// with an attribute `content` that corresponds to the window

if (typeof module !== "undefined" && module !== null) {
    module.exports = saveAs;
} else if ((typeof define !== "undefined" && define !== null) && (define.amd != null)) {
    define([], function() {
        return saveAs;
    });
}