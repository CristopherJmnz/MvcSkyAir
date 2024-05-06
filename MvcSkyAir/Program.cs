using Microsoft.AspNetCore.Authentication.Cookies;
using MvcSkyAir.Repositories;
using MvcSkyAir.Services;
using MvcSkyAir.Helpers;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllersWithViews(options=>options.EnableEndpointRouting=false);
builder.Services.AddDistributedMemoryCache();
builder.Services.AddMemoryCache();
//builder.Services.AddAntiforgery();
builder.Services.AddHttpContextAccessor();
builder.Services.AddTransient<ISkyAirRepository,SkyAirService>();
builder.Services.AddSingleton<HelperPathProvider>();
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;

}).AddCookie();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.UseMvc(routes =>
{
    routes.MapRoute(
        name: "default",
        template: "{controller=Home}/{action=Index}/{id?}");
});

IWebHostEnvironment env = app.Environment;
Rotativa.AspNetCore.RotativaConfiguration.Setup(env.WebRootPath, "../Rotativa/Windows");


app.Run();
