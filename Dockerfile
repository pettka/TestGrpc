FROM mcr.microsoft.com/dotnet/sdk:7.0 as build
WORKDIR /src
COPY . /src
RUN dotnet restore ./TestGrpc.csproj
RUN dotnet build ./TestGrpc.csproj -c Release

FROM mcr.microsoft.com/dotnet/aspnet:7.0 as final
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
# COPY bin/Release/net7.0/ /app
COPY --from=build /src/bin/Release/net7.0/ /app
WORKDIR /app
ENTRYPOINT ["dotnet", "TestGrpc.dll"]