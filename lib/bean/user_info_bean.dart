class UserInfoBean {
	UserInfoData data;
	int errorCode;
	String errorMsg;

	UserInfoBean({this.data, this.errorCode, this.errorMsg});

	UserInfoBean.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new UserInfoData.fromJson(json['data']) : null;
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}

class UserInfoData {
	String password;
	List<Null> chapterTops;
	String icon;
	String nickname;
	bool admin;
	List<Null> collectIds;
	int id;
	int type;
	String email;
	String token;
	String username;

	UserInfoData({this.password, this.chapterTops, this.icon, this.nickname, this.admin, this.collectIds, this.id, this.type, this.email, this.token, this.username});

	UserInfoData.fromJson(Map<String, dynamic> json) {
		password = json['password'];
		if (json['chapterTops'] != null) {
			chapterTops = new List<Null>();
		}
		icon = json['icon'];
		nickname = json['nickname'];
		admin = json['admin'];
		if (json['collectIds'] != null) {
			collectIds = new List<Null>();
		}
		id = json['id'];
		type = json['type'];
		email = json['email'];
		token = json['token'];
		username = json['username'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['password'] = this.password;
		if (this.chapterTops != null) {
      data['chapterTops'] =  [];
    }
		data['icon'] = this.icon;
		data['nickname'] = this.nickname;
		data['admin'] = this.admin;
		if (this.collectIds != null) {
      data['collectIds'] =  [];
    }
		data['id'] = this.id;
		data['type'] = this.type;
		data['email'] = this.email;
		data['token'] = this.token;
		data['username'] = this.username;
		return data;
	}
}
