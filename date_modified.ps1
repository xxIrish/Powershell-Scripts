DirectoryInfo d = new DirectoryInfo(@"D:\docs\"); //Assuming docs is your Folder
FileInfo[] Files = d.GetFiles("*.docx"); // returns file info of all files which is having docx extension

foreach(FileInfo file in Files) {
    if (file.LastWriteTime < new System.DateTime(2014, 1, 1)){
        file.Delete();
    }
}