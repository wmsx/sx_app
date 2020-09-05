//平台号
import 'package:flutter/material.dart';

const PLATFORM_IOS = 1;
const PLATFORM_ANDROID = 2;
const PLATFORM_WEB = 3;

const DEFAULT_VERSION = 2;

// cmd
const MSG_AUTH_TOKEN = 15;
const MSG_AUTH_STATUS = 3;

//客户端->服务端
const MSG_SYNC_GROUP = 30; //同步超级群消息
//服务端->客服端
const MSG_SYNC_GROUP_BEGIN = 31;
const MSG_SYNC_GROUP_END = 32;

const Color scaffolColor = Color(0xFFFEFEFE);
const Color c1 = Color(0xFFB1A1EC);
const Color c2 = Color(0xFF9DA7EE);

const Gradient cardGradient = LinearGradient(
  colors: [c1, c2],
);
