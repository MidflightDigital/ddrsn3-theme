--[ja] 最初、追加命令の先頭に ya をつけるつもりだったけどめんどくさくなったの図 

function yaGetKeyMode(song)
	local keymode=0;
	if song then
		local path=song:GetSongDir();
			keymode=(FILEMAN:DoesFileExist(path.."../yubi.fumen") or
				FILEMAN:DoesFileExist(path.."yubi.fumen") or
				FILEMAN:DoesFileExist(path.."../key.mode") or
				FILEMAN:DoesFileExist(path.."key.mode"));
	end;
	return keymode;
end;

function yaGetRD(player,prm)
	return GetDirectRadar(player):GetValue(prm);
end;

function yaGetRadarVal(song,player,prm,keymode)
	local ret=0.0;
	--local keymode=yaGetKeyMode(song);
	if song then
		local r_mlr  =yaGetRD(player,'RadarCategory_Mines')/16+yaGetRD(player,'RadarCategory_Lifts')/2+yaGetRD(player,'RadarCategory_Rolls');
		local r_total=yaGetRD(player,'RadarCategory_TapsAndHolds')
		if prm=="Stream" then
			if not keymode then
				ret=yaGetRD( player, 'RadarCategory_Stream')+(r_mlr/r_total);
			else
				ret=((yaGetRD( player, 'RadarCategory_TapsAndHolds' )+r_mlr*1.5+yaGetRD( player, 'RadarCategory_Jumps' ))/song:MusicLengthSeconds())/(666/60);
			end;
		elseif prm=="Voltage" then
			if not keymode then
				ret=yaGetRD( player, 'RadarCategory_Voltage')+(r_mlr*0.003);
			else
				local bpmAvg=(song:GetLastBeat()-song:GetFirstBeat())/(song:GetLastSecond()-song:GetFirstSecond())*60;
				ret=((yaGetRD( player, 'RadarCategory_TapsAndHolds' )+r_mlr+yaGetRD( player, 'RadarCategory_Jumps' ))/song:GetLastBeat())/573*bpmAvg;
			end;
		elseif prm=="Air" then
			if not keymode then
				ret=yaGetRD( player, 'RadarCategory_Air')+yaGetRD(player,'RadarCategory_Mines')/400;
			else
				ret=(yaGetRD( player, 'RadarCategory_Jumps' )/song:MusicLengthSeconds())/(200/60);
			end;
		elseif prm=="Freeze" then
			if not keymode then
				ret=yaGetRD( player, 'RadarCategory_Freeze');
			else
				if song:MusicLengthSeconds()>0 then
					ret=(yaGetRD( player, 'RadarCategory_Holds' )/song:MusicLengthSeconds())/(100/60);
				else
					ret=(yaGetRD( player, 'RadarCategory_Holds' )/(100/60));
				end;
			end;
		elseif prm=="Chaos" then
			if not keymode then
				ret=yaGetRD( player, 'RadarCategory_Chaos')+yaGetRD(player,'RadarCategory_Mines')/1000;
			else
				ret=((((yaGetRD( player, 'RadarCategory_TapsAndHolds' )-50)/song:GetLastBeat())/3)+(yaGetRD( player, 'RadarCategory_Chaos')))/2;
				if ret<0 then ret=0.0; end;
				ret=math.cos((ret+2)*math.pi*2/4)+1.0;
			end;
		else
			ret=0.0;
		end;
	end;
	if ret<0 then
		ret=0.0;
	end;
	return math.min(ret*95,95)+5;
end;

function GetJacketPath_a1(song)
	local f={};
	local ret="";
	f=FILEMAN:GetDirListing(song:GetSongDir());
	for i=1,#f do
		if string.find(f[i],".*jacket%.[png$jpeg$jpg$gif$bmp$avi$mpg$mpeg]") then
			if FILEMAN:DoesFileExist(song:GetSongDir().."/"..f[i]) then
				ret=song:GetSongDir().."/"..f[i];
				return ret;
			else
				ret="";
			end;
		end;
	end;
	return ret;
end;

function GetHarderDiffculty()
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		return GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
	elseif not GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		return GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
	elseif not GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		return 'Difficulty_Edit';
	else
		local pd={0,0};
		for i=1,2 do
			if GAMESTATE:GetCurrentSteps("PlayerNumber_P"..i):GetDifficulty()=='Difficulty_Beginner' then
				pd[i]=1;
			elseif GAMESTATE:GetCurrentSteps("PlayerNumber_P"..i):GetDifficulty()=='Difficulty_Easy' then
				pd[i]=2;
			elseif GAMESTATE:GetCurrentSteps("PlayerNumber_P"..i):GetDifficulty()=='Difficulty_Medium' then
				pd[i]=3;
			elseif GAMESTATE:GetCurrentSteps("PlayerNumber_P"..i):GetDifficulty()=='Difficulty_Hard' then
				pd[i]=4;
			elseif GAMESTATE:GetCurrentSteps("PlayerNumber_P"..i):GetDifficulty()=='Difficulty_Challenge' then
				pd[i]=5;
			else
				pd[i]=0;
			end;
		end;
		if pd[1]>=pd[2] then
			return GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
		else
			return GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
		end;
	end;
	return 'Difficulty_Edit';
end;

--[ja] SDVXみたいに難易度で変わるジャケット 
--     ホイールだと更新タイミングがよくわからず、 
--     なおかつGetJacketPath使用時に誤認識されるので没 
function GetJacketPath_Dif(song)
	local f={};
	local ret="";
	f=FILEMAN:GetDirListing(song:GetSongDir());
	for i=1,#f do
		local test=string.lower(ToEnumShortString(GetHarderDiffculty()));
		if string.find(f[i],".*jacket.*%("..test.."%)%.[png$jpeg$jpg$gif$bmp$avi$mpg$mpeg]") then
			if FILEMAN:DoesFileExist(song:GetSongDir().."/"..f[i]) then
				ret=song:GetSongDir().."/"..f[i];
				return ret;
			else
				ret="";
			end;
		end;
	end;
	return GetJacketPath_a1(song);
end;

function HasJacket_a1(song)
	local f={};
	local ret="";
	f=FILEMAN:GetDirListing(song:GetSongDir());
	for i=1,#f do
		if string.find(f[i],".*jacket.*[png$jpeg$jpg$gif$bmp$avi$mpg$mpeg]") then
			if FILEMAN:DoesFileExist(song:GetSongDir().."/"..f[i]) then
				return true;
			end;
		end;
	end;
	return false;
end;

function GetCDImagePath_a1(song)
	local f={};
	local ret="";
	f=FILEMAN:GetDirListing(song:GetSongDir());
	for i=1,#f do
		if string.find(f[i],".+cd.?[png$jpeg$jpg$gif$bmp$avi$mpg$mpeg]") then
			if FILEMAN:DoesFileExist(song:GetSongDir().."/"..f[i]) then
				ret=song:GetSongDir().."/"..f[i];
				return ret;
			else
				ret="";
			end;
		end;
	end;
	return ret;
end;

function HasCDImage_a1(song)
	local f={};
	local ret="";
	f=FILEMAN:GetDirListing(song:GetSongDir());
	for i=1,#f do
		if string.find(f[i],".+cd.?[png$jpeg$jpg$gif$bmp$avi$mpg$mpeg]") then
			if FILEMAN:DoesFileExist(song:GetSongDir().."/"..f[i]) then
				return true;
			end;
		end;
	end;
	return false;
end;

--[ja] もっともふさわしい画像のパスを返す 
function GetSongGPath(song)
	local gpath;
	if song then
		if ProductVersion()=="v5.0 alpha 1" then
			--[ja] ジャケット
			if HasJacket_a1(song) then
				gpath=GetJacketPath_a1(song);
			-- [ja] CD
			elseif HasCDImage_a1(song) then
				gpath=GetCDImagePath_a1(song);
			-- [ja] バナー
			elseif song:HasBanner() then
				gpath=song:GetBannerPath();
			-- [ja] BG 
			elseif song:HasBackground() then
				gpath=song:GetBackgroundPath();
			-- [ja] fallback 
			else
				gpath=THEME:GetPathG("Common fallback","background");
			end;
		else
			--[ja] ジャケット
			if song:HasJacket() then
				gpath=song:GetJacketPath();
			-- [ja] CD
			elseif song:HasCDImage() then
				gpath=song:GetCDImagePath();
			-- [ja] バナー
			elseif song:HasBanner() then
				gpath=song:GetBannerPath();
			-- [ja] BG 
			elseif song:HasBackground() then
				gpath=song:GetBackgroundPath();
			-- [ja] fallback 
			else
				gpath=THEME:GetPathG("Common fallback","background");
			end;
		end;
	else
		gpath=THEME:GetPathG("Common fallback","background");
	end;
	return gpath;
end;

--[ja] もっともふさわしい画像のタイプを返す 
function GetSongGType(song)
	local gtype;
	if song then
		if ProductVersion()=="v5.0 alpha 1" then
			--[ja] ジャケット
			--if song:HasJacket() then
			--elseif song:HasCDImage() then
			if HasJacket_a1(song) then
				gtype=3;
			-- [ja] CD
			elseif HasCDImage_a1(song) then
				gtype=4;
			-- [ja] バナー
			elseif song:HasBanner() then
				gtype=1;
			-- [ja] BG 
			elseif song:HasBackground() then
				gtype=2;
			-- [ja] fallback 
			else
				gtype=0;
			end;
		else
			--[ja] ジャケット
			if song:HasJacket() then
				gtype=3;
			-- [ja] CD
			elseif song:HasCDImage() then
				gtype=4;
			-- [ja] バナー
			elseif song:HasBanner() then
				gtype=1;
			-- [ja] BG 
			elseif song:HasBackground() then
				gtype=2;
			-- [ja] fallback 
			else
				gtype=0;
			end;
		end;
	else
		gtype=0;
	end;
	return gtype;
end;

--[ja] もっともふさわしい画像のキャッシュファイルパスを返す 
--     理想としてはこのファイルを読み込んでから0.1秒後に本来の画像を読むことで
--     高速化を図ろうとしたが
--     ホイールの画像にsleepやlinear使うと動きがおかしくなるので没 
function GetSongCachePath(song,gtype)
	if song then
		if gtype==3 or string.lower(gtype)=="jacket" then
			if FILEMAN:DoesFileExist(song:GetSongDir().."/cache-jk.bmp") then
				return song:GetSongDir().."/cache-jk.bmp";
			end;
			if ProductVersion()=="v5.0 alpha 1" then
				if HasJacket_a1(song) then
					return GetJacketPath_a1(song);
				else
				end;
			else
				return song:GetJacketPath();
			end;
		end;
	end;
	return "";
end;

--[ja] SMファイルで指定したパラメータの内容を読み取る  
function GetSMParameter(song,prm)
	local st=song:GetAllSteps();
	if #st<1 then
		return "";
	end;
	local t;
	t=st[1]:GetFilename();
	if not FILEMAN:DoesFileExist(t) then
		return "";
	end;
	--[ja] 形式ではじく 
	local lt=string.lower(t);
	if not string.find(lt,".*%.sm") and not string.find(lt,".*%.ssc") then
		return "";
	end;
	local f=RageFileUtil.CreateRageFile();
	f:Open(t,1);
	-- [ja] 複数行を考慮していったん別変数に代入する 
	local gl="";
	local pl=string.lower(prm);
	local l;
	while true do
		l=f:GetLine();
		local ll=string.lower(l);
		if string.find(ll,"#notes:.*") or f:AtEOF() then
			break;
		-- [ja] BOM考慮して .* を頭につける 
		elseif string.find(ll,"^.*#"..pl..":.*") or gl~="" then
			gl=gl..""..split("//",l)[1];
			if string.find(ll,".*;") then
				break;
			end;
		end;
	end;
	local tmp={};
	if gl=="" then
		tmp={""};
	else
		tmp=split(":",gl);
		if tmp[2]==";" then
			tmp[1]="";
		else
			tmp=split(";",tmp[2]);
		end;
	end;
	f:Close();
	f:destroy();
	if tmp[1]=="" then
		tmp[1]=GetExtendedParameter(song,prm);
	end;
	return tmp[1];
end;

function OpenSMFile(song)
	local st=song:GetAllSteps();
	if #st<1 then
		return nil;
	end;
	local t;
	t=st[1]:GetFilename();
	if not FILEMAN:DoesFileExist(t) then
		return nil;
	end;
	--[ja] 形式ではじく 
	local lt=string.lower(t);
	if not string.find(lt,".*%.sm") and not string.find(lt,".*%.ssc") then
		return nil;
	end;
	local f=RageFileUtil.CreateRageFile();
	f:Open(t,1);
	return f;
end;
--[ja] SMファイルで指定したパラメータの内容を読み取る（FILE型を直接指定） 
--[ja] あらかじめ OpenSMFile で開いておく必要があり、最後に f:Close() / f:destroy() をする必要がある 
--[ja] どうも解放がうまくいかなかったりするんであんまり使わないほうがいい？ 
function GetSMParameter_f(f,prm)
	if not f then
		return "";
	end;
	f:Seek(0);
	local tmp={};
	local pl=string.lower(prm);
	local l;
	local bomchk=false;
	while true do
		l=f:GetLine();
		local ll=string.lower(l);
		if string.find(ll,"#notes:.*") or f:AtEOF() then
			tmp[1]="";
			break;
		elseif string.find(ll,"^.*#"..pl..":.*") then
			tmp=split(":",l);
			if tmp[2]==";" then
				tmp[1]="";
			else
				tmp=split(";",tmp[2]);
			end;
			break;
		end;
	end;
	return tmp[1];
end;

function Str2Color(prm)
	local c={"1.0","1.0","1.0","1.0"};
	c=split(",",prm);
	if #c<4 then
		c={"1.0","1.0","1.0","1.0"};
	end;
	return c;
end;

function GetGroupParameter(group,prm)
	local gpath;
	if FILEMAN:DoesFileExist("/Songs/"..group.."/group.ini") then
		gpath="/Songs/"..group.."/group.ini";
	elseif FILEMAN:DoesFileExist("/AdditionalSongs/"..group.."/group.ini") then
		gpath="/AdditionalSongs/"..group.."/group.ini";
	else
		return "";
	end;
	local f=RageFileUtil.CreateRageFile();
	f:Open(gpath,1);
	local tmp=GetSMParameter_f(f,prm);
	f:Close();
	f:destroy();
	return tmp;
end;

function GetSongColor_MeterType(song)
	local st=GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
	local hm=song:HasStepsTypeAndDifficulty(st:GetStepsType(),'Difficulty_Hard');
	local dm=0;
	if hm then
		dm=song:GetOneSteps(st:GetStepsType(),'Difficulty_Hard'):GetMeter();
	else
		dm=0;
	end;
	if mettype=="" then
		c=SONGMAN:GetSongColor(song);
	elseif mettype=="ddr" and dm>=11 then
		c=Color("Red");
	elseif mettype=="ddr x" and dm>=17 then
		c=Color("Red");
	elseif mettype=="itg" and dm>=13 then
		c=Color("Red");
	else
		c=Color("White");
	end;
	return {c[1],c[2],c[3],c[4]};
end;

-- [ja] SM5非対応コマンドを保存する 
function SetExtendedParameter(song,prm,var)
	-- [ja] ファイル名で使用できない文字列がある場合は保存を行わない 
	if string.find(prm,".*[$<$>$%*$:$;$%?$\"$|$\\$/].*") then
		return "";
	end;
	--if string.find(var,".*[$<$>$%*$:$;$%?$\"$|$\\$/].*") then
	if string.find(var,".*[$<$>$%*$:$;$%?$\"$|$\\$/]") then
		return "";
	end;
	if not song then
		return "";
	end;
	local f_exp=RageFileUtil.CreateRageFile();
	f_exp:Open(song:GetSongDir().."/"..prm..";"..var..".smexp",2);
	f_exp:Write("-- [ja] これはStepMania5.0で対応していないパラメータを記録させているファイルです \n-- [ja] 削除しても動作に問題ありません ");
	f_exp:Close();
	f_exp:destroy();
end;

-- [ja] SM5非対応コマンドを読み込む 
function GetExtendedParameter(song,prm)
	local f={};
	local ret={};
	local lprm=string.lower(prm)
	f=FILEMAN:GetDirListing(song:GetSongDir());
	for i=1,#f do
		if string.find(string.lower(f[i]),lprm..";.*%.smexp") then
			ret=split(";",f[i]);
			ret=split(".smexp",ret[2]);
			return ret[1];
		end;
	end;
	return "";
end;

-- [ja] 左側1P、右側2Pとする処理の場合そのプレイヤーが存在するかどうか 
-- [ja] もし存在しない場合は反対側のプレイヤーを返す 
function GetSidePlayer(player)
	if player==PLAYER_1 then
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			return PLAYER_1;
		else
			return PLAYER_2;
		end;
	else
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			return PLAYER_2;
		else
			return PLAYER_1;
		end;
	end;
	return PLAYER_1;
end;

-- [ja] 現在のビートを取得する（譜面で異なるものに対応） 
function GetPlayerSongBeat(player)
	local csteps=GAMESTATE:GetCurrentSteps(player);
	local timing=csteps:GetTimingData();
	return timing:GetBeatFromElapsedTime(GAMESTATE:GetSongPosition():GetMusicSeconds());
end;

-- [ja] 上記命令＋時間がわかっているとき（高速化） 
function GetPlayerSongBeat2(player,sec)
	local csteps=GAMESTATE:GetCurrentSteps(player);
	local timing=csteps:GetTimingData();
	return timing:GetBeatFromElapsedTime(sec);
end;

-- [ja] 時間からビートに変換（譜面で異なるものに対応） 
function Sec2PlayerBeat(player,sec)
local csteps=GAMESTATE:GetCurrentSteps(player);
local timing=csteps:GetTimingData();
	return timing:GetBeatFromElapsedTime(sec);
end;

-- [ja] 何故かGetReverseで0.000...しか返らないので 
function IsReverse(pn)
	local op=string.lower(GAMESTATE:GetPlayerState(pn):GetPlayerOptionsString('ModsLevel_Stage'));
	--if string.find(op,"[reverse$split$alternate$cross]") then
	if string.find(op,"reverse") then
		return true;
	else
		return false;
	end;
	return false;
end;

-- [ja] スコアの総調べを行い正しいパラメータを返す 
-- hiscore=xxx:GetHighScores()
local GradeVar = {
	Grade_Tier01 = 0;
	Grade_Tier02 = 1;
	Grade_Tier03 = 2;
	Grade_Tier04 = 3;
	Grade_Tier05 = 4;
	Grade_Tier06 = 5;
	Grade_Tier07 = 6;
	Grade_Tier08 = 7;
	Grade_Tier09 = 8;
	Grade_Tier10 = 9;
	Grade_Tier11 = 10;
	Grade_Tier12 = 11;
	Grade_Tier13 = 12;
	Grade_Tier14 = 13;
	Grade_Tier15 = 14;
	Grade_Tier16 = 15;
	Grade_Tier17 = 16;
	Grade_Tier18 = 17;
	Grade_Tier19 = 18;
	Grade_Tier20 = 19;
	Grade_Failed = 20;
};
local StageAwrdVar = {
	StageAward_80PercentW3   = 0;
	StageAward_90PercentW3   = 1;
	StageAward_100PercentW3  = 2;
	StageAward_FullComboW3   = 3;
	StageAward_SingleDigitW3 = 4;
	StageAward_OneW3         = 5;
	StageAward_FullComboW2   = 6;
	StageAward_SingleDigitW2 = 7;
	StageAward_OneW2         = 8;
	StageAward_FullComboW1   = 9;
};
function GetScoreData(hiscore,prm)
	lprm=string.lower(prm)
	if lprm=="grade" then	-- [ja] 最高グレード 
		local higrade=99;
		for i=1,#hiscore do
			if GradeVar[hiscore[i]:GetGrade()]<higrade then
				higrade=GradeVar[hiscore[i]:GetGrade()];
			end;
		end;
		return Grade[higrade+1];
	elseif lprm=="combo" then	-- [ja] 最高コンボ 
		local hicombo=-1;
		for i=1,#hiscore do
			if hiscore[i]:GetStageAward() then
				if StageAwrdVar[hiscore[i]:GetStageAward()]>hicombo then
					hicombo=StageAwrdVar[hiscore[i]:GetStageAward()];
				end;
			end;
		end;
		if hicombo>=0 and hicombo<6 then
			return "JudgmentLine_W3";
		elseif hicombo>=6 and hicombo<8 then
			return "JudgmentLine_W2";
		elseif hicombo==9 then
			return "JudgmentLine_W1";
		else
			return "";
		end;
	else	-- [ja] 最高DP/その時のスコア/アイテム番号 
		local hidp=0;
		local hi_i=1;
		for i=1,#hiscore do
			if hiscore[i]:GetPercentDP()>hidp then
				hidp=hiscore[i]:GetPercentDP();
				hi_i=i;
			end;
		end;
		if lprm=="score" then
			return hiscore[hi_i]:GetScore();
		elseif lprm=="dp" then
			return hidp;
		else
			return hi_i;
		end;
	end;
end;
