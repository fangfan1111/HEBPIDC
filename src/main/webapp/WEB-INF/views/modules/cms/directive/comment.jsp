<%@ page contentType="text/html;charset=UTF-8" %>
是否分页&nbsp;&nbsp;
是<input  type="radio" name="page" value="true" />
否<input type="radio" name="page" value="false" checked="checked"/>
<br/>
推荐&nbsp;&nbsp;
所有<input  type="radio" name="recommend" value="all" checked="checked"/>
是<input  type="radio" name="recommend" value="true" />
否<input type="radio" name="recommend" value="false" />
<br/>
审核&nbsp;&nbsp;
所有<input  type="radio" name="checked" value="all" />
是<input  type="radio" name="checked" value="true" checked="checked"/>
否<input type="radio" name="checked" value="false" />
<br/>
排序&nbsp;&nbsp;
按评论时间降序<input  type="radio" name="orderBy" value="false" checked="checked"/>
按评论时间升序<input type="radio" name="orderBy" value="true" />
<br/>
文本显示长度
<input name="textLen"  required="true" class="required digits" maxlength="10"/><br/>
条数
<input name="count"  required="true" class="required digits" maxlength="10"/><br/>