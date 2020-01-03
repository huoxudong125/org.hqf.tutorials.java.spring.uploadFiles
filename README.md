# org.hqf.tutorials.spring.uploadFiles

基于JAVA Spring WebMVC 开发的上传文件功能，注意关注点有：
1. Spring MVC Multipart Configuration

    ```xml
    <beans:bean id="multipartResolver"
            class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
    
             <!-- setting maximum upload size -->
            <beans:property name="maxUploadSize" value="100000" />
    
    </beans:bean>
    ```
   >**Notice** that I am setting maximum upload size limit by providing the maxUploadSize property value for multipartResolver bean. If you will look into the source code of DispatcherServlet class, you will see that a MultipartResolver variable with name `multipartResolver` is defined and initialized in below method.
           
    ```
     private void initMultipartResolver(ApplicationContext context)
     {
       try
       {
         this.multipartResolver = ((MultipartResolver)context.getBean("multipartResolver", MultipartResolver.class));
         if (this.logger.isDebugEnabled()) {
           this.logger.debug("Using MultipartResolver [" + this.multipartResolver + "]");
         }
       }
       catch (NoSuchBeanDefinitionException ex)
       {
         this.multipartResolver = null;
         if (this.logger.isDebugEnabled())
           this.logger.debug("Unable to locate MultipartResolver with name 'multipartResolver': no multipart request handling provided");
       }
     }                                                                                                ```                                                                                                                                                                                                                                                                  
2. Spring File Upload Controller Class
    ```java
    /**
	 * Upload single file using Spring Controller
	 */
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public @ResponseBody
	String uploadFileHandler(@RequestParam("name") String name,
			@RequestParam("file") MultipartFile file) {

		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				// Creating the directory to store file
				String rootPath = System.getProperty("catalina.home");
				File dir = new File(rootPath + File.separator + "tmpFiles");
				if (!dir.exists())
					dir.mkdirs();

				// Create the file on server
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + name);
				BufferedOutputStream stream = new BufferedOutputStream(
						new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();

				logger.info("Server File Location="
						+ serverFile.getAbsolutePath());

				return "You successfully uploaded file=" + name;
			} catch (Exception e) {
				return "You failed to upload " + name + " => " + e.getMessage();
			}
		} else {
			return "You failed to upload " + name
					+ " because the file was empty.";
		}
	}
    ```


## reference
[spring-mvc-file-upload-example-single-multiple-files](https://www.journaldev.com/2573/spring-mvc-file-upload-example-single-multiple-files)  
[file-upload-example using serverlet direcctly](https://github.com/bobbylight/file-upload-example)  
