-- when they say fallback they mean fallback, as in "sorry, we're going to
-- import the stuff from ScreenSelectMusic decorations anyways" fallback.
local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")
t[#t+1] = StandardDecorationFromFile("NumCourseStages","NumCourseStages")
t[#t+1] = StandardDecorationFromFile("CourseTime","CourseTime")

-- course contents list (the worst part)
t[#t+1] = StandardDecorationFromFile("CourseContentsList","CourseContentsList")

return t