#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

# Use Alpine Base Image
FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine AS publish
WORKDIR /src
COPY ["DotNetApi.API/DotNetApi.API.csproj", "DotNetApi.API/"]

COPY . .
WORKDIR "/src/DotNetApi.API"
RUN dotnet restore "DotNetApi.API.csproj" --runtime alpine-x64
RUN dotnet publish "DotNetApi.API.csproj" -c Release -o /app/publish \
    --no-restore \
    --runtime alpine-x64 \
    --self-contained true \
    /p:PublishTrimmed=true \
    /p:PublishSingleFile=true

# use different image
FROM mcr.microsoft.com/dotnet/runtime-deps:5.0-alpine AS final
WORKDIR /app


# Use Alpine Base Image
EXPOSE 80
EXPOSE 443
COPY --from=publish /app/publish .
ENTRYPOINT ["./DotNetApi.API"]

