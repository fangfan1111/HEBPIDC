平台2.2.2集成FastDFS升级日志：

1.修改项目pom文件，升级huazx-commonIDC的版本号到2.2.2。

2.在src\main\resources路径下添加fdfs_client.conf文件，根据部署的FastDFS文件系统，修改相应地址。

3.修改src\main\resources\system.properties文件，增加属性值FILE_UPLOAD_TYPE=HEBPIDC（HEBPIDC：表示本地文件系统；FASTDFS：表示分布式文件系统）

4.更新src\main\webapp\WEB-INF\tags\sys\myuploadlocal.tag文件。

5.更新src\main\webapp\WEB-INF\tags\tlds\fns.tld文件。

6.在src\main\resources\mappings\modules\sys下，新增SysAttachmentDao.xml

7.更新src\main\webapp\WEB-INF\web.xml。

8.创建附件表