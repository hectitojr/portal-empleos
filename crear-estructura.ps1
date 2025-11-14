# Ruta base del proyecto frontend actualizado
$basePath = "D:\PROYECTOS\EMPLEOS\job-portal\job-portal-frontend-actualizado"

# Crear carpeta base si no existe
if (!(Test-Path -LiteralPath $basePath)) {
    New-Item -ItemType Directory -LiteralPath $basePath | Out-Null
}

# =========================
# 1) Directorios a crear
# =========================
$directories = @(
    "src",
    "src\app",
    "src\app\(public)",
    "src\app\(public)\auth",
    "src\app\(public)\auth\login",
    "src\app\(public)\auth\register",
    "src\app\(public)\auth\forgot-password",
    "src\app\(public)\auth\reset-password",
    "src\app\(public)\jobs",
    "src\app\(public)\jobs\[id]",

    "src\app\(applicant)",
    "src\app\(applicant)\applicant",
    "src\app\(applicant)\applicant\profile",

    "src\app\(company)",
    "src\app\(company)\company",
    "src\app\(company)\company\jobs",
    "src\app\(company)\company\jobs\new",

    "src\app\api",
    "src\app\api\_lib",
    "src\app\api\auth",
    "src\app\api\auth\login",
    "src\app\api\auth\register",
    "src\app\api\auth\refresh",
    "src\app\api\auth\logout",
    "src\app\api\auth\forgot",
    "src\app\api\auth\reset",
    "src\app\api\jobs",
    "src\app\api\jobs\[id]",

    "src\features",
    "src\features\iam",
    "src\features\iam\components",
    "src\features\iam\hooks",
    "src\features\iam\api",
    "src\features\iam\schemas",
    "src\features\iam\forms",

    "src\features\jobs",
    "src\features\jobs\components",
    "src\features\jobs\hooks",
    "src\features\jobs\api",
    "src\features\jobs\schemas",

    "src\features\home",
    "src\features\home\components",
    "src\features\home\hooks",
    "src\features\home\lib",

    "src\features\applicants",
    "src\features\companies",
    "src\features\applications",

    "src\components",
    "src\components\ui",
    "src\components\layout",

    "src\hooks",

    "src\lib",

    "src\stores",

    "src\styles"
)

foreach ($dir in $directories) {
    $fullDir = Join-Path -Path $basePath -ChildPath $dir
    if (!(Test-Path -LiteralPath $fullDir)) {
        New-Item -ItemType Directory -LiteralPath $fullDir | Out-Null
    }
}

# =========================
# 2) Archivos a crear
# =========================
$files = @(
    # app (public)
    "src\app\(public)\layout.tsx",
    "src\app\(public)\page.tsx",

    "src\app\(public)\auth\layout.tsx",
    "src\app\(public)\auth\login\page.tsx",
    "src\app\(public)\auth\register\page.tsx",
    "src\app\(public)\auth\forgot-password\page.tsx",
    "src\app\(public)\auth\reset-password\page.tsx",

    "src\app\(public)\jobs\page.tsx",
    "src\app\(public)\jobs\[id]\page.tsx",

    # app (applicant)
    "src\app\(applicant)\layout.tsx",
    "src\app\(applicant)\applicant\page.tsx",
    "src\app\(applicant)\applicant\profile\page.tsx",

    # app (company)
    "src\app\(company)\layout.tsx",
    "src\app\(company)\company\page.tsx",
    "src\app\(company)\company\jobs\page.tsx",
    "src\app\(company)\company\jobs\new\page.tsx",

    # app api _lib
    "src\app\api\_lib\cookies.ts",
    "src\app\api\_lib\http.ts",

    # app api auth
    "src\app\api\auth\login\route.ts",
    "src\app\api\auth\register\route.ts",
    "src\app\api\auth\refresh\route.ts",
    "src\app\api\auth\logout\route.ts",
    "src\app\api\auth\forgot\route.ts",
    "src\app\api\auth\reset\route.ts",

    # app api jobs
    "src\app\api\jobs\route.ts",
    "src\app\api\jobs\[id]\route.ts",

    # app root
    "src\app\layout.tsx",
    "src\app\providers.tsx",
    "src\app\middleware.ts",

    # features/iam
    "src\features\iam\components\AuthHeader.tsx",
    "src\features\iam\components\BackButton.tsx",
    "src\features\iam\components\PasswordField.tsx",
    "src\features\iam\components\TextField.tsx",
    "src\features\iam\components\ToggleAuthLink.tsx",
    "src\features\iam\components\TermsCheckboxes.tsx",
    "src\features\iam\components\RoleSelect.tsx",

    "src\features\iam\hooks\useAuthState.ts",
    "src\features\iam\hooks\useSession.ts",

    "src\features\iam\api\authClient.ts",
    "src\features\iam\api\iam.mutations.ts",

    "src\features\iam\schemas\auth.schema.ts",

    "src\features\iam\types.ts",

    "src\features\iam\forms\LoginCard.tsx",

    # features/jobs
    "src\features\jobs\components\JobSummaryCard.tsx",
    "src\features\jobs\components\JobDetailContent.tsx",

    "src\features\jobs\hooks\useJobsList.ts",
    "src\features\jobs\hooks\useJobDetail.ts",

    "src\features\jobs\api\jobsClient.ts",

    "src\features\jobs\schemas\jobs.filters.schema.ts",

    "src\features\jobs\types.ts",

    # features/home
    "src\features\home\components\SearchBar.tsx",
    "src\features\home\components\FeaturedJobs.tsx",
    "src\features\home\components\HomeJobCard.tsx",

    "src\features\home\hooks\useLandingState.ts",

    "src\features\home\lib\data.ts",
    "src\features\home\lib\types.ts",

    "src\features\home\index.ts",

    # components
    "src\components\ui\button.tsx",
    "src\components\ui\input.tsx",
    "src\components\ui\label.tsx",

    "src\components\layout\PublicShell.tsx",

    # lib
    "src\lib\cn.ts",
    "src\lib\env.ts",
    "src\lib\errors.ts",
    "src\lib\fetcher.ts",
    "src\lib\http.ts",
    "src\lib\routes.ts",
    "src\lib\types.ts",

    # stores
    "src\stores\ui.ts",

    # styles
    "src\styles\globals.css",

    # middleware a nivel src
    "src\middleware.ts"
)

foreach ($file in $files) {
    $fullFile = Join-Path -Path $basePath -ChildPath $file
    $dir = Split-Path -Path $fullFile -Parent

    if (!(Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -LiteralPath $dir | Out-Null
    }

    if (!(Test-Path -LiteralPath $fullFile)) {
        New-Item -ItemType File -LiteralPath $fullFile | Out-Null
    }
}

Write-Host ""
Write-Host "✅ Estructura creada/actualizada en:" -ForegroundColor Green
Write-Host "   $basePath" -ForegroundColor Cyan
