package cn.com.app.common;

public class FieldEnum {
	
	public static enum CheckEnum{
		ACCESS_STATUS_VALID(0,"无效"),
		ACCESS_STATUS_APPROVAL(1,"有效"),
		ACCESS_STATUS_NOTSURE(2,"无法确定");
		
		private int status;
		private String description;	
		
		CheckEnum(int status,String description){
			this.status = status;
			this.description = description;
		}
		
		public static String getEnumByStatus(int status){
			for(CheckEnum ce : CheckEnum.values()){
				if(ce.status == status)
					return ce.description;
			}
			return null;
		}

		public int getStatus() {
			return status;
		}

		public void setStatus(int status) {
			this.status = status;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}
		
	}
	
	public static enum UserTypeEnum{
		USER_TYPE_ADMIN(1,"管理员"),
		USER_TYPE_USER(0,"普通用户");
		
		private int type;
		private String description;	
		
		UserTypeEnum(int type,String description){
			this.type = type;
			this.description = description;
		}
		
		public static String getEnumByStatus(int type){
			for(UserTypeEnum ce : UserTypeEnum.values()){
				if(ce.type == type)
					return ce.description;
			}
			return null;
		}
		
		public int getType() {
			return type;
		}
		
		public void setType(int type) {
			this.type = type;
		}
		
		public String getDescription() {
			return description;
		}
		
		public void setDescription(String description) {
			this.description = description;
		}
		
	}
	
	public static enum UserStatusEnum{
		USER_STATUS_EXIST(0,"存在"),
		USER_STATUS_VALID(1,"已删除");
		
		private int status;
		private String description;	
		
		UserStatusEnum(int status,String description){
			this.status = status;
			this.description = description;
		}
		
		public static String getDesByStatus(int status){
			for(UserStatusEnum ce : UserStatusEnum.values()){
				if(ce.status == status)
					return ce.description;
			}
			return null;
		}

		public int getStatus() {
			return status;
		}

		public void setStatus(int status) {
			this.status = status;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}
	}

}
